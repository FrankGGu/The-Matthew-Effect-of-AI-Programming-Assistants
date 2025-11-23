#include <stdio.h>
#include <stdlib.h>
#include <limits.h>

typedef struct {
    int row;
    int col;
    int time;
} Node;

typedef struct {
    Node *data;
    int front;
    int rear;
    int size;
    int capacity;
} Queue;

Queue *createQueue(int capacity) {
    Queue *q = (Queue *)malloc(sizeof(Queue));
    q->data = (Node *)malloc(capacity * sizeof(Node));
    q->front = 0;
    q->rear = -1;
    q->size = 0;
    q->capacity = capacity;
    return q;
}

void enqueue(Queue *q, Node node) {
    if (q->size == q->capacity) return;
    q->rear = (q->rear + 1) % q->capacity;
    q->data[q->rear] = node;
    q->size++;
}

Node dequeue(Queue *q) {
    Node node = q->data[q->front];
    q->front = (q->front + 1) % q->capacity;
    q->size--;
    return node;
}

int isEmpty(Queue *q) {
    return q->size == 0;
}

int max(int a, int b) {
    return a > b ? a : b;
}

int min(int a, int b) {
    return a < b ? a : b;
}

int** updateMatrix(int** matrix, int matrixSize, int* matrixColSize, int* returnSize, int** returnColumnSizes) {
    int rows = matrixSize;
    int cols = matrixColSize[0];
    int** dist = (int**)malloc(rows * sizeof(int*));
    for (int i = 0; i < rows; i++) {
        dist[i] = (int*)malloc(cols * sizeof(int));
    }

    Queue *q = createQueue(rows * cols);
    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            if (matrix[i][j] == 0) {
                dist[i][j] = 0;
                enqueue(q, (Node){i, j, 0});
            } else {
                dist[i][j] = INT_MAX;
            }
        }
    }

    int directions[4][2] = {{-1, 0}, {1, 0}, {0, -1}, {0, 1}};
    while (!isEmpty(q)) {
        Node current = dequeue(q);
        for (int d = 0; d < 4; d++) {
            int newRow = current.row + directions[d][0];
            int newCol = current.col + directions[d][1];
            if (newRow >= 0 && newRow < rows && newCol >= 0 && newCol < cols) {
                if (dist[newRow][newCol] == INT_MAX) {
                    dist[newRow][newCol] = current.time + 1;
                    enqueue(q, (Node){newRow, newCol, current.time + 1});
                }
            }
        }
    }

    *returnSize = rows;
    *returnColumnSizes = (int*)malloc(rows * sizeof(int));
    for (int i = 0; i < rows; i++) {
        (*returnColumnSizes)[i] = cols;
    }

    return dist;
}

int findMinimumTimeToReachLastRoom(int** dungeon, int dungeonSize, int* dungeonColSize) {
    int rows = dungeonSize;
    int cols = dungeonColSize[0];
    int** dist = updateMatrix(dungeon, rows, dungeonColSize, &rows, NULL);
    return dist[rows - 1][cols - 1];
}