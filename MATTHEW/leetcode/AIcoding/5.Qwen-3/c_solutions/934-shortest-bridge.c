#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

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

bool isEmpty(Queue* q) {
    return q->size == 0;
}

void freeQueue(Queue* q) {
    free(q->data);
    free(q);
}

int dx[] = {-1, 1, 0, 0};
int dy[] = {0, 0, -1, 1};

void dfs(int** grid, int rows, int cols, int x, int y, bool** visited) {
    if (x < 0 || x >= rows || y < 0 || y >= cols || visited[x][y] || grid[x][y] == 0) return;
    visited[x][y] = true;
    for (int i = 0; i < 4; i++) {
        dfs(grid, rows, cols, x + dx[i], y + dy[i], visited);
    }
}

int shortestBridge(int** grid, int gridSize, int* gridColSize) {
    int rows = gridSize;
    int cols = *gridColSize;
    bool** visited = (bool**)malloc(rows * sizeof(bool*));
    for (int i = 0; i < rows; i++) {
        visited[i] = (bool*)calloc(cols, sizeof(bool));
    }

    bool found = false;
    for (int i = 0; i < rows && !found; i++) {
        for (int j = 0; j < cols && !found; j++) {
            if (grid[i][j] == 1) {
                dfs(grid, rows, cols, i, j, visited);
                found = true;
            }
        }
    }

    Queue* q = createQueue(rows * cols);
    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            if (visited[i][j]) {
                enqueue(q, (Point){i, j});
            }
        }
    }

    int steps = 0;
    while (!isEmpty(q)) {
        int size = q->size;
        for (int k = 0; k < size; k++) {
            Point p = dequeue(q);
            for (int i = 0; i < 4; i++) {
                int nx = p.x + dx[i];
                int ny = p.y + dy[i];
                if (nx >= 0 && nx < rows && ny >= 0 && ny < cols && !visited[nx][ny]) {
                    if (grid[nx][ny] == 1) {
                        freeQueue(q);
                        for (int i = 0; i < rows; i++) free(visited[i]);
                        free(visited);
                        return steps;
                    }
                    visited[nx][ny] = true;
                    enqueue(q, (Point){nx, ny});
                }
            }
        }
        steps++;
    }

    freeQueue(q);
    for (int i = 0; i < rows; i++) free(visited[i]);
    free(visited);
    return -1;
}