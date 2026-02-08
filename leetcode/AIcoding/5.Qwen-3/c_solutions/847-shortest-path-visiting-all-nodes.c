#include <stdio.h>
#include <stdlib.h>
#include <limits.h>
#include <stdbool.h>

typedef struct {
    int node;
    int mask;
} State;

typedef struct {
    int size;
    int capacity;
    State *data;
} Queue;

void enqueue(Queue *q, State s) {
    if (q->size == q->capacity) {
        q->capacity *= 2;
        q->data = (State *)realloc(q->data, q->capacity * sizeof(State));
    }
    q->data[q->size++] = s;
}

State dequeue(Queue *q) {
    return q->data[--q->size];
}

bool isEmpty(Queue *q) {
    return q->size == 0;
}

int shortestPathLength(int** graph, int graphSize, int* graphColSize) {
    int n = graphSize;
    int target = (1 << n) - 1;
    int *dist = (int *)calloc(n * (1 << n), sizeof(int));
    Queue q;
    q.size = 0;
    q.capacity = 1;
    q.data = (State *)malloc(sizeof(State));

    for (int i = 0; i < n; i++) {
        int mask = 1 << i;
        dist[i * (1 << n) + mask] = 0;
        enqueue(&q, (State){i, mask});
    }

    int directions[] = {0, 1, 2, 3};
    int dirCount = 4;

    while (!isEmpty(&q)) {
        State current = dequeue(&q);
        int node = current.node;
        int mask = current.mask;
        int currentDist = dist[node * (1 << n) + mask];

        if (mask == target) {
            free(q.data);
            free(dist);
            return currentDist;
        }

        for (int i = 0; i < graphColSize[node]; i++) {
            int neighbor = graph[node][i];
            int newMask = mask | (1 << neighbor);
            int index = neighbor * (1 << n) + newMask;
            if (dist[index] == 0 && mask != newMask) {
                dist[index] = currentDist + 1;
                enqueue(&q, (State){neighbor, newMask});
            }
        }
    }

    free(q.data);
    free(dist);
    return -1;
}