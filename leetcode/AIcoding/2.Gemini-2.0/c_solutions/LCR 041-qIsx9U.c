#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    int *queue;
    int head;
    int tail;
    int size;
    int capacity;
    double sum;
} MovingAverage;

MovingAverage* movingAverageCreate(int size) {
    MovingAverage* obj = (MovingAverage*)malloc(sizeof(MovingAverage));
    obj->queue = (int*)malloc(sizeof(int) * size);
    obj->head = 0;
    obj->tail = 0;
    obj->size = 0;
    obj->capacity = size;
    obj->sum = 0.0;
    return obj;
}

double movingAverageNext(MovingAverage* obj, int val) {
    if (obj->size == obj->capacity) {
        obj->sum -= obj->queue[obj->head];
        obj->head = (obj->head + 1) % obj->capacity;
        obj->size--;
    }
    obj->queue[obj->tail] = val;
    obj->tail = (obj->tail + 1) % obj->capacity;
    obj->sum += val;
    obj->size++;
    return obj->sum / obj->size;
}

void movingAverageFree(MovingAverage* obj) {
    free(obj->queue);
    free(obj);
}