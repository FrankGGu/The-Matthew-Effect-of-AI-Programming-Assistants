#include <stdlib.h>

#define QUEUE_CAPACITY 10002

typedef struct {
    int* queue;
    int head;
    int tail;
    int capacity;
} RecentCounter;

RecentCounter* recentCounterCreate() {
    RecentCounter* obj = (RecentCounter*) malloc(sizeof(RecentCounter));
    obj->queue = (int*) malloc(sizeof(int) * QUEUE_CAPACITY);
    obj->head = 0;
    obj->tail = 0;
    obj->capacity = QUEUE_CAPACITY;
    return obj;
}

int recentCounterPing(RecentCounter* obj, int t) {
    obj->queue[obj->tail] = t;
    obj->tail = (obj->tail + 1) % obj->capacity;

    while (obj->head != obj->tail && obj->queue[obj->head] < t - 3000) {
        obj->head = (obj->head + 1) % obj->capacity;
    }

    return (obj->tail - obj->head + obj->capacity) % obj->capacity;
}

void recentCounterFree(RecentCounter* obj) {
    free(obj->queue);
    free(obj);
}