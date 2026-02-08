#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    int *queue;
    int head;
    int tail;
    int capacity;
} RecentCounter;

RecentCounter* recentCounterCreate() {
    RecentCounter* obj = (RecentCounter*)malloc(sizeof(RecentCounter));
    obj->capacity = 10000;
    obj->queue = (int*)malloc(obj->capacity * sizeof(int));
    obj->head = 0;
    obj->tail = 0;
    return obj;
}

int recentCounterPing(RecentCounter* obj, int t) {
    obj->queue[obj->tail] = t;
    obj->tail = (obj->tail + 1) % obj->capacity;

    while (obj->queue[obj->head] < t - 3000) {
        obj->head = (obj->head + 1) % obj->capacity;
    }

    if (obj->tail >= obj->head) {
        return obj->tail - obj->head;
    } else {
        return obj->capacity - obj->head + obj->tail;
    }
}

void recentCounterFree(RecentCounter* obj) {
    free(obj->queue);
    free(obj);
}