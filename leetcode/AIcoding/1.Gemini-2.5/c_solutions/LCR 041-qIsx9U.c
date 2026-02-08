#include <stdlib.h>

typedef struct {
    int *queue;
    int head;
    int tail;
    int capacity;
    long long sum;
    int count;
} MovingAverage;

MovingAverage* movingAverageCreate(int size) {
    MovingAverage* obj = (MovingAverage*)malloc(sizeof(MovingAverage));
    obj->queue = (int*)malloc(sizeof(int) * size);
    obj->head = 0;
    obj->tail = 0;
    obj->capacity = size;
    obj->sum = 0;
    obj->count = 0;
    return obj;
}

double movingAverageNext(MovingAverage* obj, int val) {
    if (obj->count == obj->capacity) {
        obj->sum -= obj->queue[obj->head];
        obj->head = (obj->head + 1) % obj->capacity;
    } else {
        obj->count++;
    }

    obj->sum += val;
    obj->queue[obj->tail] = val;
    obj->tail = (obj->tail + 1) % obj->capacity;

    return (double)obj->sum / obj->count;
}

void movingAverageFree(MovingAverage* obj) {
    free(obj->queue);
    free(obj);
}