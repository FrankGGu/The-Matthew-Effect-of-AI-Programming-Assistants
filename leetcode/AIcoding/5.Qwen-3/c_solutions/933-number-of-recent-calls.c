#include <stdio.h>
#include <stdlib.h>

typedef struct {
    int* queue;
    int front;
    int rear;
    int size;
} RecentCalls;

RecentCalls* recentCallsCreate() {
    RecentCalls* obj = (RecentCalls*)malloc(sizeof(RecentCalls));
    obj->queue = (int*)malloc(1000 * sizeof(int));
    obj->front = 0;
    obj->rear = 0;
    obj->size = 0;
    return obj;
}

int recentCallsHit(RecentCalls* obj, int t) {
    while (obj->front < obj->rear && obj->queue[obj->front] < t - 3000) {
        obj->front++;
    }
    obj->queue[obj->rear++] = t;
    obj->size++;
    return obj->size;
}

void recentCallsFree(RecentCalls* obj) {
    free(obj->queue);
    free(obj);
}