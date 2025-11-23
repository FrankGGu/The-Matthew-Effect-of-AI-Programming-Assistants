#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    int *queue;
    int head;
    int tail;
    int capacity;
    int size;
} MyCircularQueue;

MyCircularQueue* myCircularQueueCreate(int k) {
    MyCircularQueue* obj = (MyCircularQueue*)malloc(sizeof(MyCircularQueue));
    obj->queue = (int*)malloc(sizeof(int) * k);
    obj->head = 0;
    obj->tail = -1;
    obj->capacity = k;
    obj->size = 0;
    return obj;
}

bool myCircularQueueEnQueue(MyCircularQueue* obj, int value) {
    if (obj->size == obj->capacity) {
        return false;
    }
    obj->tail = (obj->tail + 1) % obj->capacity;
    obj->queue[obj->tail] = value;
    obj->size++;
    return true;
}

bool myCircularQueueDeQueue(MyCircularQueue* obj) {
    if (obj->size == 0) {
        return false;
    }
    obj->head = (obj->head + 1) % obj->capacity;
    obj->size--;
    return true;
}

int myCircularQueueFront(MyCircularQueue* obj) {
    if (obj->size == 0) {
        return -1;
    }
    return obj->queue[obj->head];
}

int myCircularQueueRear(MyCircularQueue* obj) {
    if (obj->size == 0) {
        return -1;
    }
    return obj->queue[obj->tail];
}

bool myCircularQueueIsEmpty(MyCircularQueue* obj) {
    return obj->size == 0;
}

bool myCircularQueueIsFull(MyCircularQueue* obj) {
    return obj->size == obj->capacity;
}

void myCircularQueueFree(MyCircularQueue* obj) {
    free(obj->queue);
    free(obj);
}