#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

#define MAX_SIZE 1000

typedef struct {
    int *arr;
    int front;
    int rear;
} Queue;

void initQueue(Queue *q) {
    q->arr = (int *)malloc(MAX_SIZE * sizeof(int));
    q->front = 0;
    q->rear = 0;
}

bool isEmpty(Queue *q) {
    return q->front == q->rear;
}

void enqueue(Queue *q, int value) {
    q->arr[q->rear++] = value;
}

int dequeue(Queue *q) {
    return q->arr[q->front++];
}

void freeQueue(Queue *q) {
    free(q->arr);
}

int snakesAndLadders(int** board, int boardSize, int* boardColSize) {
    int n = boardSize;
    int visited[n * n];
    for (int i = 0; i < n * n; i++) visited[i] = 0;

    Queue q;
    initQueue(&q);
    enqueue(&q, 0);
    visited[0] = 1;

    int steps = 0;
    while (!isEmpty(&q)) {
        int size = q.rear - q.front;
        for (int i = 0; i < size; i++) {
            int pos = dequeue(&q);
            if (pos == n * n - 1) {
                freeQueue(&q);
                return steps;
            }
            for (int j = 1; j <= 6; j++) {
                int next = pos + j;
                if (next < n * n) {
                    int r = n - 1 - next / n;
                    int c = next % n;
                    if (r % 2 == n % 2) c = n - 1 - c;
                    if (board[r][c] != -1) next = board[r][c] - 1;
                    if (!visited[next]) {
                        visited[next] = 1;
                        enqueue(&q, next);
                    }
                }
            }
        }
        steps++;
    }
    freeQueue(&q);
    return -1;
}