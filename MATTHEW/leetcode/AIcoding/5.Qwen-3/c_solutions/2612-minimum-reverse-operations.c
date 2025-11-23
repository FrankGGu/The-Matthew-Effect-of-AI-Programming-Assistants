#include <stdio.h>
#include <stdlib.h>
#include <limits.h>

typedef struct {
    int *queue;
    int front;
    int rear;
    int size;
} Queue;

Queue* createQueue(int capacity) {
    Queue* q = (Queue*)malloc(sizeof(Queue));
    q->queue = (int*)malloc(capacity * sizeof(int));
    q->front = 0;
    q->rear = -1;
    q->size = 0;
    return q;
}

void enqueue(Queue* q, int value) {
    q->rear = (q->rear + 1) % (sizeof(q->queue)/sizeof(q->queue[0]));
    q->queue[q->rear] = value;
    q->size++;
}

int dequeue(Queue* q) {
    int val = q->queue[q->front];
    q->front = (q->front + 1) % (sizeof(q->queue)/sizeof(q->queue[0]));
    q->size--;
    return val;
}

int isEmpty(Queue* q) {
    return q->size == 0;
}

void freeQueue(Queue* q) {
    free(q->queue);
    free(q);
}

int* getMinReverseOperations(int n, int* edges, int edgesSize, int* resultSize) {
    int* dist = (int*)calloc(n, sizeof(int));
    for (int i = 0; i < n; i++) {
        dist[i] = -1;
    }

    int** adj = (int**)malloc(n * sizeof(int*));
    for (int i = 0; i < n; i++) {
        adj[i] = (int*)malloc(0);
    }

    for (int i = 0; i < edgesSize; i += 2) {
        int u = edges[i];
        int v = edges[i + 1];
        int* newAdjU = (int*)realloc(adj[u], (sizeof(int) * (sizeof(adj[u])/sizeof(adj[u][0]) + 1)));
        newAdjU[sizeof(newAdjU)/sizeof(newAdjU[0]) - 1] = v;
        adj[u] = newAdjU;

        int* newAdjV = (int*)realloc(adj[v], (sizeof(int) * (sizeof(adj[v])/sizeof(adj[v][0]) + 1)));
        newAdjV[sizeof(newAdjV)/sizeof(newAdjV[0]) - 1] = u;
        adj[v] = newAdjV;
    }

    Queue* q = createQueue(n);
    dist[0] = 0;
    enqueue(q, 0);

    while (!isEmpty(q)) {
        int u = dequeue(q);
        for (int i = 0; i < sizeof(adj[u])/sizeof(adj[u][0]); i++) {
            int v = adj[u][i];
            if (dist[v] == -1) {
                dist[v] = dist[u] + 1;
                enqueue(q, v);
            }
        }
    }

    for (int i = 0; i < n; i++) {
        if (dist[i] == -1) {
            dist[i] = 0;
        }
    }

    *resultSize = n;
    return dist;
}