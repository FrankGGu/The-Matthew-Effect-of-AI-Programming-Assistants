#include <stdio.h>
#include <stdlib.h>

typedef struct {
    int* queue;
    int front;
    int rear;
    int capacity;
} RecentRequests;

RecentRequests* recent_requests_create() {
    RecentRequests* obj = (RecentRequests*)malloc(sizeof(RecentRequests));
    obj->queue = (int*)malloc(3 * sizeof(int));
    obj->front = 0;
    obj->rear = 0;
    obj->capacity = 3;
    return obj;
}

int recent_requests_ping(RecentRequests* obj, int t) {
    int* newQueue = (int*)malloc((obj->capacity + 1) * sizeof(int));
    for (int i = 0; i < obj->capacity; i++) {
        newQueue[i] = obj->queue[i];
    }
    free(obj->queue);
    obj->queue = newQueue;
    obj->capacity++;
    obj->queue[obj->rear++] = t;
    while (obj->queue[obj->front] < t - 3000) {
        obj->front++;
    }
    return obj->rear - obj->front;
}

void recent_requests_free(RecentRequests* obj) {
    free(obj->queue);
    free(obj);
}