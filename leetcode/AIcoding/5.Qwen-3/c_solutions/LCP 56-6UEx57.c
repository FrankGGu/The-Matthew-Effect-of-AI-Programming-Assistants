#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    int* data;
    int capacity;
    int front;
    int rear;
    int size;
} Queue;

Queue* createQueue(int capacity) {
    Queue* q = (Queue*)malloc(sizeof(Queue));
    q->data = (int*)malloc(capacity * sizeof(int));
    q->capacity = capacity;
    q->front = 0;
    q->rear = -1;
    q->size = 0;
    return q;
}

void enqueue(Queue* q, int value) {
    if (q->size == q->capacity) return;
    q->rear = (q->rear + 1) % q->capacity;
    q->data[q->rear] = value;
    q->size++;
}

int dequeue(Queue* q) {
    if (q->size == 0) return -1;
    int value = q->data[q->front];
    q->front = (q->front + 1) % q->capacity;
    q->size--;
    return value;
}

int isEmpty(Queue* q) {
    return q->size == 0;
}

void freeQueue(Queue* q) {
    free(q->data);
    free(q);
}

int** getDirections(int** root, int rootSize, int** target, int targetSize, int** result, int* returnSize, int** returnColumnSizes) {
    int** res = (int**)malloc(0);
    *returnSize = 0;
    *returnColumnSizes = NULL;
    return res;
}