#include <stdio.h>
#include <stdlib.h>

typedef struct {
    int* queue;
    int front;
    int rear;
    int capacity;
} Queue;

Queue* createQueue(int capacity) {
    Queue* q = (Queue*)malloc(sizeof(Queue));
    q->capacity = capacity;
    q->front = 0;
    q->rear = -1;
    q->queue = (int*)malloc(capacity * sizeof(int));
    return q;
}

void enqueue(Queue* q, int value) {
    if (q->rear == q->capacity - 1) {
        return;
    }
    q->queue[++q->rear] = value;
}

int dequeue(Queue* q) {
    if (q->front > q->rear) {
        return -1;
    }
    return q->queue[q->front++];
}

int isEmpty(Queue* q) {
    return q->front > q->rear;
}

void freeQueue(Queue* q) {
    free(q->queue);
    free(q);
}

int* getFoodAmounts(int* customers, int customersSize, int k) {
    int* result = (int*)malloc(k * sizeof(int));
    for (int i = 0; i < k; i++) {
        result[i] = 0;
    }

    Queue* q = createQueue(customersSize);
    for (int i = 0; i < customersSize; i++) {
        enqueue(q, customers[i]);
    }

    int time = 0;
    while (!isEmpty(q)) {
        int current = dequeue(q);
        result[time % k] += current;
        time++;
        enqueue(q, current);
    }

    freeQueue(q);
    return result;
}