#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

typedef struct {
    int* data;
    int front;
    int rear;
    int capacity;
    int size;
} Queue;

void initQueue(Queue* q, int capacity) {
    q->data = (int*)malloc(sizeof(int) * capacity);
    q->capacity = capacity;
    q->front = 0;
    q->rear = -1;
    q->size = 0;
}

void enqueue(Queue* q, int val) {
    q->rear = (q->rear + 1) % q->capacity;
    q->data[q->rear] = val;
    q->size++;
}

int dequeue(Queue* q) {
    int val = q->data[q->front];
    q->front = (q->front + 1) % q->capacity;
    q->size--;
    return val;
}

bool isQueueEmpty(Queue* q) {
    return q->size == 0;
}

void freeQueue(Queue* q) {
    free(q->data);
    q->data = NULL;
}

#define MAX_STATE_VALUE (10000 + 11 + 1)

int minimumOperationsToMakeEqual(int x, int y) {
    if (x == y) {
        return 0;
    }

    int dist[MAX_STATE_VALUE];
    memset(dist, -1, sizeof(dist));

    Queue q;
    initQueue(&q, MAX_STATE_VALUE);

    dist[x] = 0;
    enqueue(&q, x);

    while (!isQueueEmpty(&q)) {
        int curr = dequeue(&q);

        if (curr == y) {
            freeQueue(&q);
            return dist[curr];
        }

        int next_val;

        next_val = curr - 1;
        if (next_val >= 0 && dist[next_val] == -1) {
            dist[next_val] = dist[curr] + 1;
            enqueue(&q, next_val);
        }

        next_val = curr + 1;
        if (next_val < MAX_STATE_VALUE && dist[next_val] == -1) {
            dist[next_val] = dist[curr] + 1;
            enqueue(&q, next_val);
        }

        if (curr % 5 == 0) {
            next_val = curr / 5;
            if (next_val >= 0 && dist[next_val] == -1) {
                dist[next_val] = dist[curr] + 1;
                enqueue(&q, next_val);
            }
        }

        if (curr % 11 == 0) {
            next_val = curr / 11;
            if (next_val >= 0 && dist[next_val] == -1) {
                dist[next_val] = dist[curr] + 1;
                enqueue(&q, next_val);
            }
        }
    }

    freeQueue(&q);
    return -1;
}