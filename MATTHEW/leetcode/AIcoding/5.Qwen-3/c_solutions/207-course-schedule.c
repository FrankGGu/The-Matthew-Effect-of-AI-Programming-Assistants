#include <stdio.h>
#include <stdlib.h>

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

bool canFinish(int numCourses, int** prerequisites, int prerequisitesSize, int* prerequisitesColSize) {
    int* inDegree = (int*)malloc(numCourses * sizeof(int));
    int* adjList = (int*)malloc(numCourses * sizeof(int));
    for (int i = 0; i < numCourses; i++) {
        adjList[i] = 0;
        inDegree[i] = 0;
    }

    for (int i = 0; i < prerequisitesSize; i++) {
        int course = prerequisites[i][0];
        int prerequisite = prerequisites[i][1];
        adjList[prerequisite]++;
        inDegree[course]++;
    }

    Queue* q = createQueue(numCourses);
    for (int i = 0; i < numCourses; i++) {
        if (inDegree[i] == 0) {
            enqueue(q, i);
        }
    }

    int count = 0;
    while (!isEmpty(q)) {
        int current = dequeue(q);
        count++;
        for (int i = 0; i < numCourses; i++) {
            if (adjList[i] > 0 && inDegree[i] > 0) {
                inDegree[i]--;
                if (inDegree[i] == 0) {
                    enqueue(q, i);
                }
            }
        }
    }

    free(inDegree);
    free(adjList);
    freeQueue(q);
    return count == numCourses;
}