#include <stdbool.h>
#include <stdlib.h>

#define MAX_QUEUE_SIZE 101 // Maximum number of elements in the stack is 100.

typedef struct {
    int arr[MAX_QUEUE_SIZE];
    int front;
    int rear;
    int count;
} Queue;

void queueInit(Queue* obj) {
    obj->front = 0;
    obj->rear = -1;
    obj->count = 0;
}

bool queueIsEmpty(Queue* obj) {
    return obj->count == 0;
}

bool queueIsFull(Queue* obj) {
    return obj->count == MAX_QUEUE_SIZE;
}

void queueAdd(Queue* obj, int val) {
    if (queueIsFull(obj)) {
        return; 
    }
    obj->rear = (obj->rear + 1) % MAX_QUEUE_SIZE;
    obj->arr[obj->rear] = val;
    obj->count++;
}

int queueRemove(Queue* obj) {
    if (queueIsEmpty(obj)) {
        return -1; // Should not happen based on problem constraints
    }
    int val = obj->arr[obj->front];
    obj->front = (obj->front + 1) % MAX_QUEUE_SIZE;
    obj->count--;
    return val;
}

int queuePeek(Queue* obj) {
    if (queueIsEmpty(obj)) {
        return -1; // Should not happen based on problem constraints
    }
    return obj->arr[obj->front];
}

int queueSize(Queue* obj) {
    return obj->count;
}

typedef struct {
    Queue q1;
    Queue q2;
} MyStack;

MyStack* myStackCreate() {
    MyStack* obj = (MyStack*) malloc(sizeof(MyStack));
    queueInit(&obj->q1);
    queueInit(&obj->q2);
    return obj;
}

void myStackPush(MyStack* obj, int x) {
    // Add new element to q2
    queueAdd(&obj->q2, x);

    // Move all elements from q1 to q2
    while (!queueIsEmpty(&obj->q1)) {
        queueAdd(&obj->q2, queueRemove(&obj->q1));
    }

    // Swap q1 and q2
    Queue temp = obj->q1;
    obj->q1 = obj->q2;
    obj->q2 = temp;
}

int myStackPop(MyStack* obj) {
    return queueRemove(&obj->q1);
}

int myStackTop(MyStack* obj) {
    return queuePeek(&obj->q1);
}

bool myStackEmpty(MyStack* obj) {
    return queueIsEmpty(&obj->q1);
}

void myStackFree(MyStack* obj) {
    free(obj);
}