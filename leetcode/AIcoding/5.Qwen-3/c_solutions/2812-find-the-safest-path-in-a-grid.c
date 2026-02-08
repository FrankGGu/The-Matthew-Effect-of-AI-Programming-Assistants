#include <stdio.h>
#include <stdlib.h>
#include <limits.h>

typedef struct {
    int x;
    int y;
} Point;

typedef struct {
    Point* data;
    int front;
    int rear;
    int size;
    int capacity;
} Queue;

Queue* createQueue(int capacity) {
    Queue* q = (Queue*)malloc(sizeof(Queue));
    q->data = (Point*)malloc(capacity * sizeof(Point));
    q->front = 0;
    q->rear = -1;
    q->size = 0;
    q->capacity = capacity;
    return q;
}

void enqueue(Queue* q, Point p) {
    if (q->size == q->capacity) return;
    q->rear = (q->rear + 1) % q->capacity;
    q->data[q->rear] = p;
    q->size++;
}

Point dequeue(Queue* q) {
    Point p = q->data[q->front];
    q->front = (q->front + 1) % q->capacity;
    q->size--;
    return p;
}

int isEmpty(Queue* q) {
    return q->size == 0;
}

void freeQueue(Queue* q) {
    free(q->data);
    free(q);
}

int** updateMatrix(int** grid, int gridSize, int* gridColSize, int* returnSize, int** returnColumnSizes) {
    int m = gridSize;
    int n = gridColSize[0];
    int** dist = (int**)malloc(m * sizeof(int*));
    for (int i = 0; i < m; i++) {
        dist[i] = (int*)malloc(n * sizeof(int));
    }

    Queue* q = createQueue(m * n);
    for (int i = 0; i < m; i++) {
        for (int j = 0; j < n; j++) {
            if (grid[i][j] == 0) {
                dist[i][j] = 0;
                enqueue(q, (Point){i, j});
            } else {
                dist[i][j] = INT_MAX;
            }
        }
    }

    int dirs[4][2] = {{-1, 0}, {1, 0}, {0, -1}, {0, 1}};
    while (!isEmpty(q)) {
        Point p = dequeue(q);
        for (int d = 0; d < 4; d++) {
            int x = p.x + dirs[d][0];
            int y = p.y + dirs[d][1];
            if (x >= 0 && x < m && y >= 0 && y < n && dist[x][y] == INT_MAX) {
                dist[x][y] = dist[p.x][p.y] + 1;
                enqueue(q, (Point){x, y});
            }
        }
    }

    *returnSize = m;
    *returnColumnSizes = (int*)malloc(m * sizeof(int));
    for (int i = 0; i < m; i++) {
        (*returnColumnSizes)[i] = n;
    }

    freeQueue(q);
    return dist;
}