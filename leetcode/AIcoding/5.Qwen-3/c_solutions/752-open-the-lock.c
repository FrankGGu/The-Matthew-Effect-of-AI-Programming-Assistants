#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <limits.h>

typedef struct {
    char *key;
    int dist;
} Node;

typedef struct {
    char **queue;
    int front;
    int rear;
    int size;
    int capacity;
} Queue;

Queue *createQueue(int capacity) {
    Queue *q = (Queue *)malloc(sizeof(Queue));
    q->capacity = capacity;
    q->front = 0;
    q->rear = -1;
    q->size = 0;
    q->queue = (char **)malloc(capacity * sizeof(char *));
    return q;
}

void enqueue(Queue *q, char *key) {
    if (q->size == q->capacity) return;
    q->rear = (q->rear + 1) % q->capacity;
    q->queue[q->rear] = strdup(key);
    q->size++;
}

char *dequeue(Queue *q) {
    if (q->size == 0) return NULL;
    char *key = q->queue[q->front];
    q->front = (q->front + 1) % q->capacity;
    q->size--;
    return key;
}

int isEmpty(Queue *q) {
    return q->size == 0;
}

void freeQueue(Queue *q) {
    for (int i = 0; i < q->capacity; i++) {
        free(q->queue[i]);
    }
    free(q->queue);
    free(q);
}

char **getNeighbors(char *current) {
    char **neighbors = (char **)malloc(8 * sizeof(char *));
    for (int i = 0; i < 8; i++) {
        neighbors[i] = (char *)malloc(5 * sizeof(char));
        strcpy(neighbors[i], current);
    }

    for (int i = 0; i < 4; i++) {
        int digit = current[i] - '0';
        int next = (digit + 1) % 10;
        int prev = (digit - 1 + 10) % 10;

        neighbors[2 * i][i] = '0' + next;
        neighbors[2 * i + 1][i] = '0' + prev;
    }

    return neighbors;
}

int openLock(char **deadends, int deadendsSize, char *target) {
    char *start = "0000";
    if (strcmp(start, target) == 0) return 0;

    int *visited = (int *)calloc(10000, sizeof(int));
    for (int i = 0; i < deadendsSize; i++) {
        int num = atoi(deadends[i]);
        visited[num] = 1;
    }

    if (visited[0]) return -1;

    Queue *q = createQueue(10000);
    enqueue(q, start);
    visited[0] = 1;

    int steps = 0;
    while (!isEmpty(q)) {
        int levelSize = q->size;
        for (int i = 0; i < levelSize; i++) {
            char *current = dequeue(q);
            char **neighbors = getNeighbors(current);
            for (int j = 0; j < 8; j++) {
                int num = atoi(neighbors[j]);
                if (num == atoi(target)) {
                    freeQueue(q);
                    for (int k = 0; k < 8; k++) free(neighbors[k]);
                    free(neighbors);
                    return steps + 1;
                }
                if (!visited[num]) {
                    visited[num] = 1;
                    enqueue(q, neighbors[j]);
                }
            }
            for (int k = 0; k < 8; k++) free(neighbors[k]);
            free(neighbors);
            free(current);
        }
        steps++;
    }

    freeQueue(q);
    free(visited);
    return -1;
}