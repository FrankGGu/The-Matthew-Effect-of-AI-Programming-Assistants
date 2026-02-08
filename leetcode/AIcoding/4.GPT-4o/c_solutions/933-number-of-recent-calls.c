#include <stdio.h>
#include <stdlib.h>

typedef struct {
    int* calls;
    int count;
    int size;
} RecentCounter;

RecentCounter* recentCounterCreate() {
    RecentCounter* obj = (RecentCounter*)malloc(sizeof(RecentCounter));
    obj->calls = (int*)malloc(1000 * sizeof(int));
    obj->count = 0;
    obj->size = 1000;
    return obj;
}

int recentCounterPing(RecentCounter* obj, int t) {
    if (obj->count == obj->size) {
        obj->size *= 2;
        obj->calls = (int*)realloc(obj->calls, obj->size * sizeof(int));
    }
    obj->calls[obj->count++] = t;

    while (obj->calls[0] < t - 3000) {
        for (int i = 1; i < obj->count; i++) {
            obj->calls[i - 1] = obj->calls[i];
        }
        obj->count--;
    }

    return obj->count;
}

void recentCounterFree(RecentCounter* obj) {
    free(obj->calls);
    free(obj);
}