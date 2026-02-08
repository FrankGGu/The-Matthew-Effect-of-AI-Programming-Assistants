#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    char* id;
    int count;
} TweetCount;

typedef struct {
    char* key;
    int* times;
    int size;
} TimeMap;

TimeMap* timeMapCreate() {
    TimeMap* obj = (TimeMap*)malloc(sizeof(TimeMap));
    obj->key = NULL;
    obj->times = NULL;
    obj->size = 0;
    return obj;
}

void timeMapPut(TimeMap* obj, char* key, int timestamp) {
    if (obj->key == NULL || strcmp(obj->key, key) != 0) {
        free(obj->key);
        obj->key = strdup(key);
        obj->size = 0;
        free(obj->times);
        obj->times = NULL;
    }
    obj->size++;
    obj->times = (int*)realloc(obj->times, obj->size * sizeof(int));
    obj->times[obj->size - 1] = timestamp;
}

TweetCount** timeMapGetTweetCountsByFrequency(TimeMap* obj, char* key, int startTimestamp, int endTimestamp, char* freq, int* returnSize) {
    if (obj == NULL || obj->key == NULL || strcmp(obj->key, key) != 0) {
        *returnSize = 0;
        return NULL;
    }

    int* times = obj->times;
    int size = obj->size;

    int count = 0;
    for (int i = 0; i < size; i++) {
        if (times[i] >= startTimestamp && times[i] <= endTimestamp) {
            count++;
        }
    }

    int interval;
    if (strcmp(freq, "second") == 0) {
        interval = 1;
    } else if (strcmp(freq, "minute") == 0) {
        interval = 60;
    } else if (strcmp(freq, "hour") == 0) {
        interval = 3600;
    } else {
        *returnSize = 0;
        return NULL;
    }

    int start = startTimestamp;
    int end = endTimestamp;
    int total = 0;
    while (start <= end) {
        int next = start + interval;
        int cnt = 0;
        for (int i = 0; i < size; i++) {
            if (times[i] >= start && times[i] < next) {
                cnt++;
            }
        }
        if (cnt > 0) {
            total++;
        }
        start = next;
    }

    *returnSize = total;
    TweetCount** result = (TweetCount**)malloc(total * sizeof(TweetCount*));
    int idx = 0;

    start = startTimestamp;
    while (start <= end) {
        int next = start + interval;
        int cnt = 0;
        for (int i = 0; i < size; i++) {
            if (times[i] >= start && times[i] < next) {
                cnt++;
            }
        }
        if (cnt > 0) {
            result[idx] = (TweetCount*)malloc(sizeof(TweetCount));
            result[idx]->id = strdup(key);
            result[idx]->count = cnt;
            idx++;
        }
        start = next;
    }

    return result;
}

void timeMapFree(TimeMap* obj) {
    free(obj->key);
    free(obj->times);
    free(obj);
}