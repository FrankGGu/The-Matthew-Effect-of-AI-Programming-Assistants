#include <stdio.h>
#include <stdlib.h>
#include <limits.h>

typedef struct {
    int x;
    int y;
} Point;

typedef struct {
    Point p;
    int dist;
} QueueNode;

typedef struct {
    QueueNode *data;
    int front;
    int rear;
    int size;
} Queue;

Queue* createQueue(int capacity) {
    Queue *q = (Queue*)malloc(sizeof(Queue));
    q->data = (QueueNode*)malloc(capacity * sizeof(QueueNode));
    q->front = 0;
    q->rear = -1;
    q->size = 0;
    return q;
}

void enqueue(Queue *q, Point p, int dist) {
    q->rear = (q->rear + 1) % (int)(sizeof(q->data)/sizeof(q->data[0]));
    q->data[q->rear].p = p;
    q->data[q->rear].dist = dist;
    q->size++;
}

QueueNode dequeue(Queue *q) {
    QueueNode node = q->data[q->front];
    q->front = (q->front + 1) % (int)(sizeof(q->data)/sizeof(q->data[0]));
    q->size--;
    return node;
}

int isEmpty(Queue *q) {
    return q->size == 0;
}

int shortestPath(char** grid, int gridSize, int* gridColSize) {
    int rows = gridSize;
    int cols = gridColSize[0];
    int dirs[4][2] = {{-1, 0}, {1, 0}, {0, -1}, {0, 1}};
    int **dist = (int**)malloc(rows * sizeof(int*));
    for (int i = 0; i < rows; i++) {
        dist[i] = (int*)malloc(cols * sizeof(int));
        for (int j = 0; j < cols; j++) {
            dist[i][j] = INT_MAX;
        }
    }
    Queue *q = createQueue(rows * cols);
    Point start = {0, 0};
    dist[0][0] = 0;
    enqueue(q, start, 0);
    while (!isEmpty(q)) {
        QueueNode current = dequeue(q);
        Point p = current.p;
        int d = current.dist;
        if (p.x == rows - 1 && p.y == cols - 1) {
            return d;
        }
        for (int i = 0; i < 4; i++) {
            int nx = p.x + dirs[i][0];
            int ny = p.y + dirs[i][1];
            if (nx >= 0 && nx < rows && ny >= 0 && ny < cols) {
                int new_dist = d + (grid[nx][ny] == '1' ? 1 : 0);
                if (new_dist < dist[nx][ny]) {
                    dist[nx][ny] = new_dist;
                    enqueue(q, (Point){nx, ny}, new_dist);
                }
            }
        }
    }
    return -1;
}