#include <stdio.h>
#include <stdlib.h>

typedef struct {
    int* data;
    int size;
} Queue;

Queue* createQueue(int capacity) {
    Queue* q = (Queue*)malloc(sizeof(Queue));
    q->data = (int*)malloc(capacity * sizeof(int));
    q->size = 0;
    return q;
}

void enqueue(Queue* q, int value) {
    q->data[q->size++] = value;
}

int dequeue(Queue* q) {
    int val = q->data[0];
    for (int i = 1; i < q->size; i++) {
        q->data[i - 1] = q->data[i];
    }
    q->size--;
    return val;
}

int isEmpty(Queue* q) {
    return q->size == 0;
}

void freeQueue(Queue* q) {
    free(q->data);
    free(q);
}

long long countInfectionSequences(int n, int* edges, int edgesSize) {
    int** adj = (int**)malloc(n * sizeof(int*));
    for (int i = 0; i < n; i++) {
        adj[i] = (int*)malloc(n * sizeof(int));
        for (int j = 0; j < n; j++) {
            adj[i][j] = 0;
        }
    }

    for (int i = 0; i < edgesSize; i += 2) {
        int u = edges[i];
        int v = edges[i + 1];
        adj[u][v] = 1;
        adj[v][u] = 1;
    }

    long long result = 0;
    int* visited = (int*)malloc(n * sizeof(int));
    int* parent = (int*)malloc(n * sizeof(int));

    for (int start = 0; start < n; start++) {
        for (int i = 0; i < n; i++) {
            visited[i] = 0;
        }
        Queue* q = createQueue(n);
        enqueue(q, start);
        visited[start] = 1;
        long long count = 1;
        while (!isEmpty(q)) {
            int node = dequeue(q);
            for (int neighbor = 0; neighbor < n; neighbor++) {
                if (adj[node][neighbor] && !visited[neighbor]) {
                    visited[neighbor] = 1;
                    enqueue(q, neighbor);
                    count++;
                }
            }
        }
        result += count;
    }

    for (int i = 0; i < n; i++) {
        free(adj[i]);
    }
    free(adj);
    free(visited);
    free(parent);
    return result;
}