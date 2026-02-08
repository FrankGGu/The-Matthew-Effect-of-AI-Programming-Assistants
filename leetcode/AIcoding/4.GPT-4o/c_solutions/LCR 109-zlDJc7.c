#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

typedef struct {
    char **arr;
    int front, rear, size, capacity;
} Queue;

Queue* createQueue(int capacity) {
    Queue *queue = (Queue *)malloc(sizeof(Queue));
    queue->capacity = capacity;
    queue->front = queue->size = 0;
    queue->rear = capacity - 1;
    queue->arr = (char **)malloc(capacity * sizeof(char *));
    return queue;
}

bool isFull(Queue* queue) {
    return (queue->size == queue->capacity);
}

bool isEmpty(Queue* queue) {
    return (queue->size == 0);
}

void enqueue(Queue* queue, char *item) {
    if (isFull(queue)) return;
    queue->rear = (queue->rear + 1) % queue->capacity;
    queue->arr[queue->rear] = item;
    queue->size = queue->size + 1;
}

char* dequeue(Queue* queue) {
    if (isEmpty(queue)) return NULL;
    char *item = queue->arr[queue->front];
    queue->front = (queue->front + 1) % queue->capacity;
    queue->size = queue->size - 1;
    return item;
}

bool visited[10000];

int openLock(char **deadends, int deadendsSize, char *target) {
    if (strcmp(target, "0000") == 0) return 0;
    for (int i = 0; i < deadendsSize; i++) {
        if (strcmp(deadends[i], "0000") == 0) return -1;
        visited[atoi(deadends[i])] = true;
    }

    Queue* queue = createQueue(10000);
    enqueue(queue, "0000");
    visited[0] = true;
    int steps = 0;

    while (!isEmpty(queue)) {
        int size = queue->size;
        for (int i = 0; i < size; i++) {
            char *current = dequeue(queue);
            if (strcmp(current, target) == 0) {
                free(queue->arr);
                free(queue);
                return steps;
            }
            for (int j = 0; j < 4; j++) {
                char next[5];
                strcpy(next, current);
                next[j] = (next[j] == '9') ? '0' : next[j] + 1;
                if (!visited[atoi(next)]) {
                    visited[atoi(next)] = true;
                    enqueue(queue, next);
                }
                next[j] = (next[j] == '0') ? '9' : next[j] - 1;
                if (!visited[atoi(next)]) {
                    visited[atoi(next)] = true;
                    enqueue(queue, next);
                }
            }
        }
        steps++;
    }
    free(queue->arr);
    free(queue);
    return -1;
}