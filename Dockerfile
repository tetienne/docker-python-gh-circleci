FROM python:3.9-slim

LABEL Author="Thibaut ETIENNE"

RUN apt-get -y update && apt-get install -y --no-install-recommends \
    git \
    curl \
    gpg

RUN curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | gpg --dearmor -o /usr/share/keyrings/githubcli-archive-keyring.gpg && \
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | tee /etc/apt/sources.list.d/github-cli.list > /dev/null

RUN apt-get -y update && apt-get install -y --no-install-recommends \
    gh \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

SHELL ["/bin/bash", "-o", "pipefail", "-c"]
RUN curl -fLSs https://raw.githubusercontent.com/CircleCI-Public/circleci-cli/master/install.sh | bash