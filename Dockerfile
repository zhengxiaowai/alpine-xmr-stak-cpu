FROM  alpine:latest
RUN   apk --no-cache upgrade && \
  apk --no-cache add \
    openssl-dev \
    cmake \
    g++ \
    build-base \
    git && \
  git clone https://github.com/zhengxiaowai/xmr-stak-cpu.git && \
  cd xmr-stak-cpu && \
  cmake -DMICROHTTPD_ENABLE=OFF -DHWLOC_ENABLE=OFF -DCMAKE_LINK_STATIC=ON . && \
  make && \
  apk del \
    cmake \
    g++ \
    build-base \
    git
WORKDIR		/tmp
COPY start.sh /tmp/
COPY config.txt /tmp/
RUN   adduser -S -D -H -h /xmr-stak-cpu/bin miner
RUN   chown miner /tmp/config.txt

USER miner
ENTRYPOINT	["./start.sh"]
