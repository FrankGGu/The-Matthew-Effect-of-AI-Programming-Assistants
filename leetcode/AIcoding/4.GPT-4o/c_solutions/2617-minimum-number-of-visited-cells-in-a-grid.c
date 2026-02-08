#include <stdio.h>
#include <stdlib.h>

#define MAX 1000

typedef struct {
    int x, y;
} Point;

typedef struct {
    Point points[MAX * MAX];
    int front, rear;
} Queue;

void initQueue(Queue *q) {
    q->front = 0;
    q->rear = 0;
}

int isEmpty(Queue *q) {
    return q->front == q->rear;
}

void enqueue(Queue *q, Point p) {
    q->points[q->rear++] = p;
}

Point dequeue(Queue *q) {
    return q->points[q->front++];
}

int bfs(int** grid, int gridSize, int* gridColSize) {
    int directions[2][2] = {{1, 0}, {0, 1}};
    int visited[MAX][MAX] = {0};
    Queue q;
    initQueue(&q);

    enqueue(&q, (Point){0, 0});
    visited[0][0] = 1;

    int steps = 0;
    while (!isEmpty(&q)) {
        int size = q.rear - q.front;
        steps++;

        for (int i = 0; i < size; i++) {
            Point cur = dequeue(&q);
            if (cur.x == gridSize - 1 && cur.y == *gridColSize - 1) {
                return steps;
            }

            for (int d = 0; d < 2; d++) {
                for (int k = 1; k <= grid[cur.x][cur.y]; k++) {
                    int nx = cur.x + k * directions[d][0];
                    int ny = cur.y + k * directions[d][1];
                    if (nx < gridSize && ny < *gridColSize && !visited[nx][ny]) {
                        visited[nx][ny] = 1;
                        enqueue(&q, (Point){nx, ny});
                    }
                }
            }
        }
    }
    return -1;
}

int minVisitedCells(int** grid, int gridSize, int* gridColSize) {
    if (gridSize == 0 || *gridColSize == 0) return 0;
    return bfs(grid, gridSize, gridColSize);
}