#include <stdio.h>
#include <stdlib.h>
#include <limits.h>

typedef struct {
    int row;
    int col;
} Pair;

typedef struct {
    Pair* data;
    int size;
    int capacity;
} Queue;

Queue* createQueue() {
    Queue* q = (Queue*)malloc(sizeof(Queue));
    q->size = 0;
    q->capacity = 1;
    q->data = (Pair*)malloc(q->capacity * sizeof(Pair));
    return q;
}

void enqueue(Queue* q, Pair p) {
    if (q->size == q->capacity) {
        q->capacity *= 2;
        q->data = (Pair*)realloc(q->data, q->capacity * sizeof(Pair));
    }
    q->data[q->size++] = p;
}

Pair dequeue(Queue* q) {
    Pair p = q->data[0];
    for (int i = 1; i < q->size; i++) {
        q->data[i - 1] = q->data[i];
    }
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

int min(int a, int b) {
    return a < b ? a : b;
}

int dfs(int** grid, int rows, int cols, int** dist, int r, int c, int cost) {
    if (r < 0 || c < 0 || r >= rows || c >= cols) return INT_MAX;
    if (dist[r][c] <= cost) return dist[r][c];
    dist[r][c] = cost;
    int down = dfs(grid, rows, cols, dist, r + 1, c, cost + (grid[r][c] == 1 ? 0 : 1));
    int up = dfs(grid, rows, cols, dist, r - 1, c, cost + (grid[r][c] == 2 ? 0 : 1));
    int right = dfs(grid, rows, cols, dist, r, c + 1, cost + (grid[r][c] == 3 ? 0 : 1));
    int left = dfs(grid, rows, cols, dist, r, c - 1, cost + (grid[r][c] == 4 ? 0 : 1));
    return min(min(down, up), min(right, left));
}

int minCost(int** grid, int gridSize, int* gridColSize) {
    int rows = gridSize;
    int cols = *gridColSize;
    int** dist = (int**)malloc(rows * sizeof(int*));
    for (int i = 0; i < rows; i++) {
        dist[i] = (int*)malloc(cols * sizeof(int));
        for (int j = 0; j < cols; j++) {
            dist[i][j] = INT_MAX;
        }
    }
    dfs(grid, rows, cols, dist, 0, 0, 0);
    return dist[rows - 1][cols - 1];
}