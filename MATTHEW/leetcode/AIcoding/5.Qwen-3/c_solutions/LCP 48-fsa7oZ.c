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
    q->rear = 0;
    q->capacity = capacity;
    return q;
}

void enqueue(Queue *q, Position pos, int steps) {
    q->data[q->rear].pos = pos;
    q->data[q->rear].steps = steps;
    q->rear = (q->rear + 1) % q->capacity;
}

QueueNode dequeue(Queue *q) {
    QueueNode node = q->data[q->front];
    q->front = (q->front + 1) % q->capacity;
    return node;
}

int isEmpty(Queue *q) {
    return q->front == q->rear;
}

int isVisited(int **visited, int x, int y, int rows, int cols) {
    if (x < 0 || x >= rows || y < 0 || y >= cols) return 1;
    return visited[x][y];
}

void markVisited(int **visited, int x, int y) {
    visited[x][y] = 1;
}

int bfs(int **grid, int rows, int cols) {
    int **visited = (int**)malloc(rows * sizeof(int*));
    for (int i = 0; i < rows; i++) {
        visited[i] = (int*)malloc(cols * sizeof(int));
        memset(visited[i], 0, cols * sizeof(int));
    }

    Queue *q = createQueue(rows * cols);
    Position start = {0, 0};
    enqueue(q, start, 0);
    markVisited(visited, 0, 0);

    int directions[4][2] = {{-1, 0}, {1, 0}, {0, -1}, {0, 1}};

    while (!isEmpty(q)) {
        QueueNode current = dequeue(q);
        int x = current.pos.x;
        int y = current.pos.y;
        int steps = current.steps;

        if (x == rows - 1 && y == cols - 1) {
            for (int i = 0; i < rows; i++) free(visited[i]);
            free(visited);
            free(q->data);
            free(q);
            return steps;
        }

        for (int i = 0; i < 4; i++) {
            int nx = x + directions[i][0];
            int ny = y + directions[i][1];

            if (!isVisited(visited, nx, ny, rows, cols) && grid[nx][ny] == 0) {
                markVisited(visited, nx, ny);
                enqueue(q, (Position){nx, ny}, steps + 1);
            }
        }
    }

    for (int i = 0; i < rows; i++) free(visited[i]);
    free(visited);
    free(q->data);
    free(q);
    return -1;
}

int solution(int **grid, int rows, int cols) {
    return bfs(grid, rows, cols);
}