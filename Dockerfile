FROM python:3.7

ENV APP_HOME /app
WORKDIR $APP_HOME

WORKDIR /opt/webstream

COPY ./ ./

# Setup
RUN pip3 install flask numpy opencv-contrib-python imutils
RUN pip3 install wheel
RUN python setup.py bdist_wheel

ENV FLASK_INSTANCE_DIR_NAME /var/api-instance
RUN mkdir -p $FLASK_INSTANCE_DIR_NAME
RUN python -c 'import os; print("SECRET_KEY =",os.urandom(16))' > $FLASK_INSTANCE_DIR_NAME/config.py

RUN pip3 install waitress

EXPOSE 8080

#CMD python3 webstreaming.py --source video/test_video.mp4
ENTRYPOINT ["waitress-serve", "--call", "api:create_app"]
