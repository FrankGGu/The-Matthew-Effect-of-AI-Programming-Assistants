#include <stdio.h>
#include <stdlib.h>

typedef struct {
    int* data;
    int front;
    int rear;
    int capacity;
} Queue;

typedef struct {
    Queue* q1;
    Queue* q2;
} MyStack;

Queue* queueCreate(int k) {
    Queue* obj = (Queue*)malloc(sizeof(Queue));
    obj->data = (int*)malloc(k * sizeof(int));
    obj->front = 0;
    obj->rear = 0;
    obj->capacity = k;
    return obj;
}

void queuePush(Queue* obj, int x) {
    if ((obj->rear + 1) % obj->capacity == obj->front) {
        int* new_data = (int*)malloc(obj->capacity * 2 * sizeof(int));
        int i;
        for (i = 0; i < obj->capacity; i++) {
            new_data[i] = obj->data[(obj->front + i) % obj->capacity];
        }
        free(obj->data);
        obj->data = new_data;
        obj->front = 0;
        obj->rear = obj->capacity;
        obj->capacity *= 2;
    }
    obj->data[obj->rear] = x;
    obj->rear = (obj->rear + 1) % obj->capacity;
}

int queuePop(Queue* obj) {
    int val = obj->data[obj->front];
    obj->front = (obj->front + 1) % obj->capacity;
    return val;
}

int queuePeek(Queue* obj) {
    return obj->data[obj->front];
}

int queueEmpty(Queue* obj) {
    return obj->front == obj->rear;
}

void queueFree(Queue* obj) {
    free(obj->data);
    free(obj);
}

MyStack* myStackCreate() {
    MyStack* obj = (MyStack*)malloc(sizeof(MyStack));
    obj->q1 = queueCreate(100);
    obj->q2 = queueCreate(100);
    return obj;
}

void myStackPush(MyStack* obj, int x) {
    if (!queueEmpty(obj->q1)) {
        queuePush(obj->q2, x);
        while (!queueEmpty(obj->q1)) {
            queuePush(obj->q2, queuePop(obj->q1));
        }
    } else {
        queuePush(obj->q1, x);
        while (!queueEmpty(obj->q2)) {
            queuePush(obj->q1, queuePop(obj->q2));
        }
    }
}

int myStackPop(MyStack* obj) {
    if (!queueEmpty(obj->q1)) {
        return queuePop(obj->q1);
    } else {
        return queuePop(obj->q2);
    }
}

int myStackTop(MyStack* obj) {
    if (!queueEmpty(obj->q1)) {
        return queuePeek(obj->q1);
    } else {
        return queuePeek(obj->q2);
    }
}

int myStackEmpty(MyStack* obj) {
    return queueEmpty(obj->q1) && queueEmpty(obj->q2);
}

void myStackFree(MyStack* obj) {
    queueFree(obj->q1);
    queueFree(obj->q2);
    free(obj);
}