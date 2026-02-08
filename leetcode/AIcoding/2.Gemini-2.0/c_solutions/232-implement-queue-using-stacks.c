#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    int* stack1;
    int* stack2;
    int top1;
    int top2;
    int capacity;
} MyQueue;

MyQueue* myQueueCreate() {
    MyQueue* obj = (MyQueue*)malloc(sizeof(MyQueue));
    obj->capacity = 100;
    obj->stack1 = (int*)malloc(obj->capacity * sizeof(int));
    obj->stack2 = (int*)malloc(obj->capacity * sizeof(int));
    obj->top1 = -1;
    obj->top2 = -1;
    return obj;
}

void myQueuePush(MyQueue* obj, int x) {
    obj->top1++;
    obj->stack1[obj->top1] = x;
}

int myQueuePop(MyQueue* obj) {
    if (obj->top2 == -1) {
        while (obj->top1 != -1) {
            obj->top2++;
            obj->stack2[obj->top2] = obj->stack1[obj->top1];
            obj->top1--;
        }
    }
    int val = obj->stack2[obj->top2];
    obj->top2--;
    return val;
}

int myQueuePeek(MyQueue* obj) {
    if (obj->top2 == -1) {
        while (obj->top1 != -1) {
            obj->top2++;
            obj->stack2[obj->top2] = obj->stack1[obj->top1];
            obj->top1--;
        }
    }
    return obj->stack2[obj->top2];
}

bool myQueueEmpty(MyQueue* obj) {
    return (obj->top1 == -1 && obj->top2 == -1);
}

void myQueueFree(MyQueue* obj) {
    free(obj->stack1);
    free(obj->stack2);
    free(obj);
}