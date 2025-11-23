#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

#define MAX 100000

typedef struct {
    int *data;
    int front;
    int rear;
} Queue;

Queue* createQueue() {
    Queue *q = (Queue *)malloc(sizeof(Queue));
    q->data = (int *)malloc(MAX * sizeof(int));
    q->front = 0;
    q->rear = 0;
    return q;
}

bool isEmpty(Queue *q) {
    return q->front == q->rear;
}

void enqueue(Queue *q, int val) {
    q->data[q->rear++] = val;
}

int dequeue(Queue *q) {
    return q->data[q->front++];
}

int minReverseOperations(int n, int p, int x, int y) {
    int *dist = (int *)malloc(n * sizeof(int));
    for (int i = 0; i < n; i++) dist[i] = -1;

    Queue *q = createQueue();
    enqueue(q, p);
    dist[p] = 0;

    while (!isEmpty(q)) {
        int curr = dequeue(q);

        if (curr - x >= 0 && dist[curr - x] == -1) {
            dist[curr - x] = dist[curr] + 1;
            enqueue(q, curr - x);
        }
        if (curr + x < n && dist[curr + x] == -1) {
            dist[curr + x] = dist[curr] + 1;
            enqueue(q, curr + x);
        }
        if (curr - y >= 0 && dist[curr - y] == -1) {
            dist[curr - y] = dist[curr] + 1;
            enqueue(q, curr - y);
        }
        if (curr + y < n && dist[curr + y] == -1) {
            dist[curr + y] = dist[curr] + 1;
            enqueue(q, curr + y);
        }
    }

    int minOps = MAX;
    for (int i = 0; i < n; i++) {
        if (dist[i] != -1) {
            minOps = (minOps < dist[i]) ? minOps : dist[i];
        }
    }

    free(dist);
    free(q->data);
    free(q);

    return (minOps == MAX) ? -1 : minOps;
}