#include <stdlib.h>

typedef struct {
    int* timestamps;
    int head;
    int tail;
    int capacity;
} RecentCounter;

RecentCounter* recentCounterCreate() {
    RecentCounter* obj = (RecentCounter*)malloc(sizeof(RecentCounter));
    obj->capacity = 1000;
    obj->timestamps = (int*)malloc(sizeof(int) * obj->capacity);
    obj->head = 0;
    obj->tail = 0;
    return obj;
}

int recentCounterPing(RecentCounter* obj, int t) {
    if (obj->tail == obj->capacity) {
        obj->capacity *= 2;
        obj->timestamps = (int*)realloc(obj->timestamps, sizeof(int) * obj->capacity);
    }

    obj->timestamps[obj->tail] = t;
    obj->tail++;

    while (obj->timestamps[obj->head] < t - 3000) {
        obj->head++;
    }

    return obj->tail - obj->head;
}

void recentCounterFree(RecentCounter* obj) {
    if (obj) {
        free(obj->timestamps);
        free(obj);
    }
}