#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAX_REQUESTS 10000

typedef struct {
    int timestamps[MAX_REQUESTS];
    int count;
} RecentCounter;

RecentCounter* recentCounterCreate() {
    RecentCounter* obj = (RecentCounter*)malloc(sizeof(RecentCounter));
    obj->count = 0;
    return obj;
}

int recentCounterPing(RecentCounter* obj, int t) {
    obj->timestamps[obj->count++] = t;
    while (obj->timestamps[0] < t - 3000) {
        for (int i = 1; i < obj->count; i++) {
            obj->timestamps[i - 1] = obj->timestamps[i];
        }
        obj->count--;
    }
    return obj->count;
}

void recentCounterFree(RecentCounter* obj) {
    free(obj);
}