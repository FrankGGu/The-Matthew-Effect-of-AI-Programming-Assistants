#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    int x;
    int y;
} Position;

typedef struct {
    Position pos;
    int steps;
} QueueNode;

typedef struct {
    QueueNode *data;
    int front;
    int rear;
    int capacity;
} Queue;

Queue* createQueue(int capacity) {
    Queue *q = (Queue*)malloc(sizeof(Queue));
    q->data = (QueueNode*)malloc(capacity * sizeof(QueueNode));
    q->front = 0;
    q->rear = -1;
    q->capacity = capacity;
    return q;
}

void enqueue(Queue *q, Position pos, int steps) {
    q->rear++;
    q->data[q->rear].pos = pos;
    q->data[q->rear].steps = steps;
}

QueueNode dequeue(Queue *q) {
    QueueNode node = q->data[q->front];
    q->front++;
    return node;
}

int isEmpty(Queue *q) {
    return q->front > q->rear;
}

int minMoves(char** classroom, int rows, int cols) {
    int i, j;
    int startRow = -1, startCol = -1;
    for (i = 0; i < rows; i++) {
        for (j = 0; j < cols; j++) {
            if (classroom[i][j] == 'S') {
                startRow = i;
                startCol = j;
            }
        }
    }

    int visited[rows][cols];
    for (i = 0; i < rows; i++) {
        for (j = 0; j < cols; j++) {
            visited[i][j] = 0;
        }
    }

    int directions[4][2] = {{-1, 0}, {1, 0}, {0, -1}, {0, 1}};
    Queue *q = createQueue(rows * cols);
    enqueue(q, (Position){startRow, startCol}, 0);
    visited[startRow][startCol] = 1;

    while (!isEmpty(q)) {
        QueueNode current = dequeue(q);
        int x = current.pos.x;
        int y = current.pos.y;
        int moves = current.steps;

        if (classroom[x][y] == 'T') {
            return moves;
        }

        for (i = 0; i < 4; i++) {
            int nx = x + directions[i][0];
            int ny = y + directions[i][1];

            if (nx >= 0 && nx < rows && ny >= 0 && ny < cols && !visited[nx][ny]) {
                visited[nx][ny] = 1;
                enqueue(q, (Position){nx, ny}, moves + 1);
            }
        }
    }

    return -1;
}