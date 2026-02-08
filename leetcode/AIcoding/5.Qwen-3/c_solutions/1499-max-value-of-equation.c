#include <stdio.h>
#include <stdlib.h>
#include <limits.h>

typedef struct {
    int x;
    int y;
} Point;

typedef struct {
    int value;
    int x;
} QueueNode;

typedef struct {
    QueueNode *data;
    int front;
    int rear;
    int capacity;
} Queue;

Queue* createQueue(int capacity) {
    Queue *q = (Queue*)malloc(sizeof(Queue));
    q->capacity = capacity;
    q->front = 0;
    q->rear = -1;
    q->data = (QueueNode*)malloc(capacity * sizeof(QueueNode));
    return q;
}

void enqueue(Queue *q, int value, int x) {
    if (q->rear == q->capacity - 1) {
        return;
    }
    q->rear++;
    q->data[q->rear].value = value;
    q->data[q->rear].x = x;
}

QueueNode dequeue(Queue *q) {
    QueueNode node = q->data[q->front];
    q->front++;
    return node;
}

int isEmpty(Queue *q) {
    return q->front > q->rear;
}

int maxValueOfEquation(int** points, int pointsSize, int* pointsColSize, int k) {
    Queue *q = createQueue(pointsSize);
    int maxVal = INT_MIN;
    for (int i = 0; i < pointsSize; i++) {
        int x = points[i][0];
        int y = points[i][1];
        while (!isEmpty(q) && x - q->data[q->front].x > k) {
            dequeue(q);
        }
        if (!isEmpty(q)) {
            int current = q->data[q->front].value + x + y;
            if (current > maxVal) {
                maxVal = current;
            }
        }
        enqueue(q, y - x, x);
    }
    free(q->data);
    free(q);
    return maxVal;
}