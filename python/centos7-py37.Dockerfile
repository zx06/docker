FROM centos:7

ARG PYTHON_VERSION=3.7.4

# set timezone +8
ENV TZ=Asia/Shanghai

RUN yum update -y && yum -y install \
    zlib-devel \
    bzip2-devel \
    openssl-devel \
    ncurses-devel \
    sqlite-devel \
    readline-devel \
    tk-devel \
    gdbm-devel \
    db4-devel \
    libpcap-devel \
    xz-devel \
    gcc \
    libffi-devel \
    mysql-devel \
    gcc-devel \
    make \
    wget \
    # clean cache
    && yum clean all

RUN set -ex \
    # download python source code
    && wget -O python.tar.xz https://www.python.org/ftp/python/${PYTHON_VERSION}/Python-${PYTHON_VERSION}.tar.xz \
    # create source dir
    && mkdir -p /usr/src/python \
    # uncompress source code
    && tar -xJC /usr/src/python --strip-components=1 -f python.tar.xz \
    # del compressed file
    && rm -rf python.tar.xz \
    # create python dir
    && mkdir /usr/local/python3 \
    && cd /usr/src/python \
    # configure
    && ./configure --prefix=/usr/local/python3 --enable-optimizations \
    # install
    && make && make altinstall \
    # link
    && ln -s /usr/local/python3/bin/python3.7 /usr/local/bin/python3 \
    && ln -s /usr/local/python3/bin/pip3.7 /usr/local/bin/pip3 \
    # # update pip
    && pip3 install --upgrade pip

RUN date




CMD [ "python3" ]