FROM python:3.6-alpine

#MAINTAINER jhao104 <j_hao104@163.com>

WORKDIR /app

COPY ./requirements.txt .

# apk repository
#RUN set -eux && sed -i 's/dl-cdn.alpinelinux.org/mirrors.ustc.edu.cn/g' /etc/apk/repositories && apk update
RUN echo -e "http://mirrors.ustc.edu.cn/alpine/latest-stable/main\nhttp://mirrors.ustc.edu.cn/alpine/latest-stable/community" > /etc/apk/repositories && apk update

# timezone

RUN apk  add -U tzdata && cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && apk del tzdata

# runtime environment
RUN apk add musl-dev gcc libxml2-dev libxslt-dev && \
    pip install -v --no-cache-dir -r requirements.txt -i https://pypi.tuna.tsinghua.edu.cn/simple/ && \
    apk del gcc musl-dev

COPY . .

EXPOSE 5010

ENTRYPOINT [ "sh", "start.sh" ]
