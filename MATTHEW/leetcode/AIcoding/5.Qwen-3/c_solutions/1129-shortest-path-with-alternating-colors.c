#include <stdio.h>
#include <stdlib.h>
#include <limits.h>

typedef struct {
    int* data;
    int front;
    int rear;
    int size;
    int capacity;
} Queue;

Queue* createQueue(int capacity) {
    Queue* q = (Queue*)malloc(sizeof(Queue));
    q->data = (int*)malloc(capacity * sizeof(int));
    q->front = 0;
    q->rear = -1;
    q->size = 0;
    q->capacity = capacity;
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

int* shortestAlternatingColors(int n, int** red_edges, int red_edgesSize, int* red_edgesColSize, int** blue_edges, int blue_edgesSize, int* blue_edgesColSize, int* returnSize) {
    int** adj = (int**)malloc(n * sizeof(int*));
    for (int i = 0; i < n; i++) {
        adj[i] = (int*)malloc(0);
    }

    for (int i = 0; i < red_edgesSize; i++) {
        int u = red_edges[i][0];
        int v = red_edges[i][1];
        adj[u] = (int*)realloc(adj[u], (sizeof(int) * (sizeof(adj[u]) / sizeof(int) + 1)));
        adj[u][sizeof(adj[u]) / sizeof(int) - 1] = v;
    }

    for (int i = 0; i < blue_edgesSize; i++) {
        int u = blue_edges[i][0];
        int v = blue_edges[i][1];
        adj[u] = (int*)realloc(adj[u], (sizeof(int) * (sizeof(adj[u]) / sizeof(int) + 1)));
        adj[u][sizeof(adj[u]) / sizeof(int) - 1] = v;
    }

    int* result = (int*)malloc(n * sizeof(int));
    for (int i = 0; i < n; i++) {
        result[i] = INT_MAX;
    }

    Queue* q = createQueue(n * 2);
    int* color = (int*)malloc(n * sizeof(int));
    for (int i = 0; i < n; i++) {
        color[i] = -1;
    }

    enqueue(q, 0);
    color[0] = 0;
    result[0] = 0;

    while (!isEmpty(q)) {
        int node = dequeue(q);
        int currentColor = color[node];

        for (int i = 0; i < sizeof(adj[node]) / sizeof(int); i++) {
            int neighbor = adj[node][i];
            int nextColor = (currentColor == 0) ? 1 : 0;
            if (color[neighbor] != nextColor) {
                result[neighbor] = fmin(result[neighbor], result[node] + 1);
                color[neighbor] = nextColor;
                enqueue(q, neighbor);
            }
        }
    }

    for (int i = 0; i < n; i++) {
        if (result[i] == INT_MAX) {
            result[i] = -1;
        }
    }

    *returnSize = n;
    return result;
}