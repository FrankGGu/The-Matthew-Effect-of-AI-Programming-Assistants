#include <stdio.h>
#include <stdlib.h>

typedef struct {
    int* queue;
    int capacity;
    int size;
    int front;
    int rear;
    double sum;
} MovingAverage;

MovingAverage* movingAverageCreate(int size) {
    MovingAverage* obj = (MovingAverage*)malloc(sizeof(MovingAverage));
    obj->capacity = size;
    obj->queue = (int*)malloc(size * sizeof(int));
    obj->size = 0;
    obj->front = 0;
    obj->rear = 0;
    obj->sum = 0.0;
    return obj;
}

double movingAverageNext(MovingAverage* obj, int val) {
    if (obj->size < obj->capacity) {
        obj->queue[obj->rear] = val;
        obj->rear = (obj->rear + 1) % obj->capacity;
        obj->size++;
    } else {
        obj->sum -= obj->queue[obj->front];
        obj->queue[obj->front] = val;
        obj->front = (obj->front + 1) % obj->capacity;
    }
    obj->sum += val;
    return obj->sum / obj->size;
}

void movingAverageFree(MovingAverage* obj) {
    free(obj->queue);
    free(obj);
}