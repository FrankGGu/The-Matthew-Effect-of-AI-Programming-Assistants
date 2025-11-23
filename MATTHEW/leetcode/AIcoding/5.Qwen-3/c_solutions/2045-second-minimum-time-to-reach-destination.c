#include <stdio.h>
#include <stdlib.h>
#include <limits.h>

typedef struct {
    int node;
    int time;
} Pair;

typedef struct {
    int* data;
    int front;
    int rear;
    int size;
    int capacity;
} Queue;

Queue* createQueue(int capacity) {
    Queue* q = (Queue*)malloc(sizeof(Queue));
    q->capacity = capacity;
    q->front = q->rear = -1;
    q->size = 0;
    q->data = (int*)malloc(capacity * sizeof(int));
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
    int value = q->data[q->front + 1];
    q->front = (q->front + 1) % q->capacity;
    q->size--;
    return value;
}

int isEmpty(Queue* q) {
    return q->size == 0;
}

int secondMinimum(int n, int** edges, int edgesSize, int* edgesColSize, int time, int maxTime) {
    int** graph = (int**)malloc((n + 1) * sizeof(int*));
    for (int i = 0; i <= n; i++) {
        graph[i] = (int*)malloc(0);
    }

    for (int i = 0; i < edgesSize; i++) {
        int u = edges[i][0];
        int v = edges[i][1];
        int* temp1 = (int*)realloc(graph[u], (sizeof(int) * (strlen(graph[u]) + 2)));
        temp1[strlen(graph[u])] = v;
        graph[u] = temp1;
        int* temp2 = (int*)realloc(graph[v], (sizeof(int) * (strlen(graph[v]) + 2)));
        temp2[strlen(graph[v])] = u;
        graph[v] = temp2;
    }

    int* dist = (int*)malloc((n + 1) * sizeof(int));
    for (int i = 0; i <= n; i++) {
        dist[i] = INT_MAX;
    }

    int* secondDist = (int*)malloc((n + 1) * sizeof(int));
    for (int i = 0; i <= n; i++) {
        secondDist[i] = INT_MAX;
    }

    dist[1] = 0;
    Queue* q = createQueue(n + 1);
    enqueue(q, 1);

    while (!isEmpty(q)) {
        int u = dequeue(q);
        for (int i = 0; graph[u][i] != '\0'; i++) {
            int v = graph[u][i];
            int newTime = dist[u] + 1;
            if (newTime < dist[v]) {
                secondDist[v] = dist[v];
                dist[v] = newTime;
                enqueue(q, v);
            } else if (newTime > dist[v] && newTime < secondDist[v]) {
                secondDist[v] = newTime;
                enqueue(q, v);
            }
        }
    }

    int result = secondDist[n] <= maxTime ? secondDist[n] : -1;
    free(dist);
    free(secondDist);
    for (int i = 0; i <= n; i++) {
        free(graph[i]);
    }
    free(graph);
    free(q->data);
    free(q);
    return result;
}