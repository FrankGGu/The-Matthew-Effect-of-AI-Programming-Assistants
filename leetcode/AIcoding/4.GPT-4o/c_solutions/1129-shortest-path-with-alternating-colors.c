#define MAX 1000
#include <stdlib.h>
#include <stdbool.h>

typedef struct {
    int node;
    int color;
} Node;

typedef struct {
    Node *data;
    int front;
    int rear;
    int size;
} Queue;

Queue* createQueue(int size) {
    Queue* queue = (Queue*)malloc(sizeof(Queue));
    queue->data = (Node*)malloc(size * sizeof(Node));
    queue->front = 0;
    queue->rear = 0;
    queue->size = size;
    return queue;
}

void enqueue(Queue* queue, int node, int color) {
    queue->data[queue->rear].node = node;
    queue->data[queue->rear].color = color;
    queue->rear++;
}

Node dequeue(Queue* queue) {
    return queue->data[queue->front++];
}

bool isEmpty(Queue* queue) {
    return queue->front == queue->rear;
}

void freeQueue(Queue* queue) {
    free(queue->data);
    free(queue);
}

int* shortestAlternatingPaths(int n, int** redEdges, int redEdgesSize, int** blueEdges, int blueEdgesSize, int* returnSize) {
    int *dist = (int*)malloc(n * sizeof(int));
    for (int i = 0; i < n; i++) dist[i] = -1;
    dist[0] = 0;

    int **adj = (int**)malloc(n * sizeof(int*));
    int *adjSize = (int*)malloc(n * sizeof(int));
    for (int i = 0; i < n; i++) {
        adj[i] = (int*)malloc((redEdgesSize + blueEdgesSize) * sizeof(int));
        adjSize[i] = 0;
    }

    for (int i = 0; i < redEdgesSize; i++) {
        int u = redEdges[i][0], v = redEdges[i][1];
        adj[u][adjSize[u]++] = v;
    }
    for (int i = 0; i < blueEdgesSize; i++) {
        int u = blueEdges[i][0], v = blueEdges[i][1];
        adj[u][adjSize[u]++] = v;
    }

    Queue* queue = createQueue(MAX);
    enqueue(queue, 0, 0);
    enqueue(queue, 0, 1);

    while (!isEmpty(queue)) {
        Node curr = dequeue(queue);
        int color = curr.color;
        for (int i = 0; i < adjSize[curr.node]; i++) {
            int next = adj[curr.node][i];
            if (dist[next] == -1) {
                dist[next] = dist[curr.node] + 1;
                enqueue(queue, next, color ^ 1);
            }
        }
    }

    freeQueue(queue);
    free(adj);
    free(adjSize);
    *returnSize = n;
    return dist;
}