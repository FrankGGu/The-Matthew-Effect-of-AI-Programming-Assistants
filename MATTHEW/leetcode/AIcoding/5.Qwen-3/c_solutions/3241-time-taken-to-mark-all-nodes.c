#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    int* neighbors;
    int size;
} AdjList;

typedef struct {
    int node;
    int time;
} QueueNode;

typedef struct {
    QueueNode* data;
    int front;
    int rear;
    int capacity;
} Queue;

Queue* createQueue(int capacity) {
    Queue* q = (Queue*)malloc(sizeof(Queue));
    q->data = (QueueNode*)malloc(capacity * sizeof(QueueNode));
    q->front = 0;
    q->rear = -1;
    q->capacity = capacity;
    return q;
}

void enqueue(Queue* q, int node, int time) {
    q->rear++;
    q->data[q->rear].node = node;
    q->data[q->rear].time = time;
}

int dequeue(Queue* q) {
    int node = q->data[q->front].node;
    q->front++;
    return node;
}

int isQueueEmpty(Queue* q) {
    return q->front > q->rear;
}

int* timeTaken(int n, int** edges, int edgesSize, int* edgesColSize, int* resultSize) {
    AdjList* adj = (AdjList*)malloc(n * sizeof(AdjList));
    for (int i = 0; i < n; i++) {
        adj[i].neighbors = NULL;
        adj[i].size = 0;
    }

    for (int i = 0; i < edgesSize; i++) {
        int u = edges[i][0];
        int v = edges[i][1];
        int* temp = (int*)realloc(adj[u].neighbors, (adj[u].size + 1) * sizeof(int));
        temp[adj[u].size++] = v;
        adj[u].neighbors = temp;

        temp = (int*)realloc(adj[v].neighbors, (adj[v].size + 1) * sizeof(int));
        temp[adj[v].size++] = u;
        adj[v].neighbors = temp;
    }

    int* time = (int*)calloc(n, sizeof(int));
    int* visited = (int*)calloc(n, sizeof(int));
    Queue* q = createQueue(n);

    enqueue(q, 0, 0);
    visited[0] = 1;

    while (!isQueueEmpty(q)) {
        int current = dequeue(q);
        int currTime = q->data[q->front - 1].time;

        for (int i = 0; i < adj[current].size; i++) {
            int neighbor = adj[current].neighbors[i];
            if (!visited[neighbor]) {
                visited[neighbor] = 1;
                time[neighbor] = currTime + 1;
                enqueue(q, neighbor, currTime + 1);
            }
        }
    }

    *resultSize = n;
    return time;
}