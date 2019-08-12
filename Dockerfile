FROM alpine:latest as builder

RUN apk add --update --no-cache ca-certificates gmp curl openssl libstdc++
RUN apk add --no-cache make gcc musl-dev git g++ gmp-dev curl-dev openssl-dev

RUN git clone https://github.com/aquachain/aquacppminerx.git && \
    cd /aquacppminerx && make && \
    mv bin/* /usr/local/bin/ && \
    cd / && rm -rf /aquacppminerx

FROM alpine:latest

RUN apk add --update --no-cache ca-certificates gmp curl openssl libstdc++
COPY --from=builder /usr/local/bin/aquacppminer* /usr/bin/
