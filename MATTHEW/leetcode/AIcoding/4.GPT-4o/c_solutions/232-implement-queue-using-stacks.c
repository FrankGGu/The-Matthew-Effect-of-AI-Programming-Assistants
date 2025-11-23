#include <stdio.h>
#include <stdlib.h>

typedef struct {
    int* stack1;
    int* stack2;
    int top1;
    int top2;
    int capacity;
} MyQueue;

MyQueue* myQueueCreate() {
    MyQueue* queue = (MyQueue*)malloc(sizeof(MyQueue));
    queue->capacity = 1000;
    queue->stack1 = (int*)malloc(queue->capacity * sizeof(int));
    queue->stack2 = (int*)malloc(queue->capacity * sizeof(int));
    queue->top1 = 0;
    queue->top2 = 0;
    return queue;
}

void myQueuePush(MyQueue* obj, int x) {
    obj->stack1[obj->top1++] = x;
}

int myQueuePop(MyQueue* obj) {
    if (obj->top2 == 0) {
        while (obj->top1 > 0) {
            obj->stack2[obj->top2++] = obj->stack1[--obj->top1];
        }
    }
    return obj->stack2[--obj->top2];
}

int myQueuePeek(MyQueue* obj) {
    if (obj->top2 == 0) {
        while (obj->top1 > 0) {
            obj->stack2[obj->top2++] = obj->stack1[--obj->top1];
        }
    }
    return obj->stack2[obj->top2 - 1];
}

bool myQueueEmpty(MyQueue* obj) {
    return obj->top1 == 0 && obj->top2 == 0;
}

void myQueueFree(MyQueue* obj) {
    free(obj->stack1);
    free(obj->stack2);
    free(obj);
}