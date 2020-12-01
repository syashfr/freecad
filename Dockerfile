FROM python:3.9.0-slim-buster

RUN apt-get update && apt install  -y \
	software-properties-common \
	wget \ 
    gnupg2 

#install xpra      
RUN wget -q https://xpra.org/gpg.asc -O- | apt-key add - && \
    add-apt-repository "deb https://xpra.org/ buster main" && \
    apt-get update && apt-get install -y  --no-install-recommends xpra xvfb xterm  

##install dependencies
RUN apt-get update && apt install  -y \
    libx11-dev libxcomposite-dev libxdamage-dev \
    libxkbfile-dev \
    openssh-client \
    sshpass \
    python3-paramiko \
    dbus-x11  \
    python3-requests \
    xpra-html5

#install freecad
RUN apt-get update && apt-get install -y freecad \
    && rm -rf /var/lib/apt/lists/* 
    
ENV DISPLAY=:0
EXPOSE 8051
CMD  xpra start --start=freecad --no-pulseaudio --desktop-scaling=2 --bind-tcp=0.0.0.0:8051 --html=on && tail -f /dev/null 