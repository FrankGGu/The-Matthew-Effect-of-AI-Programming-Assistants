#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

#define MAX_SIZE 100001

typedef struct {
    int index;
    int steps;
} QueueNode;

typedef struct {
    QueueNode* nodes;
    int front;
    int rear;
    int capacity;
} Queue;

Queue* createQueue(int capacity) {
    Queue* queue = (Queue*)malloc(sizeof(Queue));
    queue->capacity = capacity;
    queue->front = 0;
    queue->rear = 0;
    queue->nodes = (QueueNode*)malloc(capacity * sizeof(QueueNode));
    return queue;
}

bool isEmpty(Queue* queue) {
    return queue->front == queue->rear;
}

void enqueue(Queue* queue, QueueNode node) {
    queue->nodes[queue->rear++] = node;
}

QueueNode dequeue(Queue* queue) {
    return queue->nodes[queue->front++];
}

void freeQueue(Queue* queue) {
    free(queue->nodes);
    free(queue);
}

int minJumps(int* arr, int arrSize) {
    if (arrSize <= 1) return 0;

    int* visited = (int*)calloc(arrSize, sizeof(int));
    visited[0] = 1;

    Queue* queue = createQueue(arrSize);
    enqueue(queue, (QueueNode){0, 0});

    int* indexMap = (int*)malloc(MAX_SIZE * sizeof(int));
    for (int i = 0; i < MAX_SIZE; i++) {
        indexMap[i] = -1;
    }

    for (int i = 0; i < arrSize; i++) {
        if (indexMap[arr[i]] == -1) {
            indexMap[arr[i]] = i;
        } else {
            indexMap[arr[i]] = -2; // Mark as multiple indices
        }
    }

    while (!isEmpty(queue)) {
        QueueNode current = dequeue(queue);
        int index = current.index;
        int steps = current.steps;

        if (index == arrSize - 1) {
            freeQueue(queue);
            free(visited);
            free(indexMap);
            return steps;
        }

        if (index - 1 >= 0 && !visited[index - 1]) {
            visited[index - 1] = 1;
            enqueue(queue, (QueueNode){index - 1, steps + 1});
        }

        if (index + 1 < arrSize && !visited[index + 1]) {
            visited[index + 1] = 1;
            enqueue(queue, (QueueNode){index + 1, steps + 1});
        }

        if (indexMap[arr[index]] != -1) {
            for (int i = 0; i < arrSize; i++) {
                if (indexMap[arr[i]] == -2 || indexMap[arr[i]] == index) {
                    continue;
                }
                if (!visited[indexMap[arr[i]]]) {
                    visited[indexMap[arr[i]]] = 1;
                    enqueue(queue, (QueueNode){indexMap[arr[i]], steps + 1});
                }
            }
            indexMap[arr[index]] = -1; // Prevent further jumps on this value
        }
    }

    freeQueue(queue);
    free(visited);
    free(indexMap);
    return -1;
}