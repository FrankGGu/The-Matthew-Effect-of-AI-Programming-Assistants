#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    char tweetName[21];
    int time;
} Tweet;

typedef struct {
    Tweet *tweets;
    int count;
    int capacity;
} TweetCounts;

TweetCounts* tweetCountsCreate() {
    TweetCounts* obj = (TweetCounts*)malloc(sizeof(TweetCounts));
    obj->tweets = (Tweet*)malloc(10000 * sizeof(Tweet));
    obj->count = 0;
    obj->capacity = 10000;
    return obj;
}

void tweetCountsRecordTweet(TweetCounts* obj, char * tweetName, int time) {
    if (obj->count == obj->capacity) {
        obj->capacity *= 2;
        obj->tweets = (Tweet*)realloc(obj->tweets, obj->capacity * sizeof(Tweet));
    }
    strcpy(obj->tweets[obj->count].tweetName, tweetName);
    obj->tweets[obj->count].time = time;
    obj->count++;
}

int* tweetCountsGetTweetCountsPerFrequency(TweetCounts* obj, char * freq, char * tweetName, int startTime, int endTime, int* retSize) {
    int interval;
    if (strcmp(freq, "minute") == 0) {
        interval = 60;
    } else if (strcmp(freq, "hour") == 0) {
        interval = 3600;
    } else {
        interval = 86400;
    }

    int size = (endTime - startTime) / interval + 1;
    int* result = (int*)calloc(size, sizeof(int));
    *retSize = size;

    for (int i = 0; i < obj->count; i++) {
        if (strcmp(obj->tweets[i].tweetName, tweetName) == 0) {
            int time = obj->tweets[i].time;
            if (time >= startTime && time <= endTime) {
                int index = (time - startTime) / interval;
                result[index]++;
            }
        }
    }

    return result;
}

void tweetCountsFree(TweetCounts* obj) {
    free(obj->tweets);
    free(obj);
}