#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAX_TWEETS 10000

typedef struct {
    char* tweetName;
    int time;
} TweetRecord;

typedef struct {
    TweetRecord* records;
    int size;
    int capacity;
} TweetCounts;

TweetCounts* tweetCountsCreate() {
    TweetCounts* obj = (TweetCounts*)malloc(sizeof(TweetCounts));
    obj->capacity = 10;
    obj->size = 0;
    obj->records = (TweetRecord*)malloc(obj->capacity * sizeof(TweetRecord));
    return obj;
}

void tweetCountsRecordTweet(TweetCounts* obj, char* tweetName, int time) {
    if (obj->size == obj->capacity) {
        obj->capacity *= 2;
        obj->records = (TweetRecord*)realloc(obj->records, obj->capacity * sizeof(TweetRecord));
    }
    obj->records[obj->size].tweetName = malloc(strlen(tweetName) + 1);
    strcpy(obj->records[obj->size].tweetName, tweetName);
    obj->records[obj->size].time = time;
    obj->size++;
}

int compare(const void* a, const void* b) {
    return ((TweetRecord*)a)->time - ((TweetRecord*)b)->time;
}

int* tweetCountsGetTweetCountsPerFrequency(TweetCounts* obj, char* freq, char* tweetName, int startTime, int endTime, int* retSize) {
    int interval;
    if (strcmp(freq, "minute") == 0) {
        interval = 60;
    } else if (strcmp(freq, "hour") == 0) {
        interval = 3600;
    } else {
        interval = 86400;
    }

    int numChunks = (endTime - startTime) / interval + 1;
    int* result = (int*)calloc(numChunks, sizeof(int));

    for (int i = 0; i < obj->size; i++) {
        if (strcmp(obj->records[i].tweetName, tweetName) == 0) {
            int time = obj->records[i].time;
            if (time >= startTime && time <= endTime) {
                int chunkIndex = (time - startTime) / interval;
                result[chunkIndex]++;
            }
        }
    }

    *retSize = numChunks;
    return result;
}

void tweetCountsFree(TweetCounts* obj) {
    for (int i = 0; i < obj->size; i++) {
        free(obj->records[i].tweetName);
    }
    free(obj->records);
    free(obj);
}