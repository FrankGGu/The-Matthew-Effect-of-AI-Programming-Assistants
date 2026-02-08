#include <stdlib.h>
#include <stdbool.h>
#include <limits.h>

typedef struct {
    int r;
    int c;
    int dist;
} Cell;

typedef struct {
    Cell* cells;
    int front;
    int rear;
    int size;
    int capacity;
} Queue;

Queue* createQueue(int capacity) {
    Queue* q = (Queue*)malloc(sizeof(Queue));
    q->capacity = capacity;
    q->front = 0;
    q->rear = -1;
    q->size = 0;
    q->cells = (Cell*)malloc(q->capacity * sizeof(Cell));
    return q;
}

void enqueue(Queue* q, int r, int c, int dist) {
    if (q->size == q->capacity) return;
    q->rear = (q->rear + 1) % q->capacity;
    q->cells[q->rear].r = r;
    q->cells[q->rear].c = c;
    q->cells[q->rear].dist = dist;
    q->size++;
}

Cell dequeue(Queue* q) {
    if (q->size == 0) {
        Cell empty = {-1, -1, -1};
        return empty;
    }
    Cell cell = q->cells[q->front];
    q->front = (q->front + 1) % q->capacity;
    q->size--;
    return cell;
}

bool isEmpty(Queue* q) {
    return q->size == 0;
}

void freeQueue(Queue* q) {
    free(q->cells);
    free(q);
}

int shortestPathBinaryMatrix(int** grid, int gridSize, int* gridColSize) {
    if (gridSize == 0 || gridColSize[0] == 0) return -1;
    int R = gridSize;
    int C = gridColSize[0];

    if (grid[0][0] == 1 || grid[R - 1][C - 1] == 1) return -1;

    int dr[] = {-1, -1, -1, 0, 0, 1, 1, 1};
    int dc[] = {-1, 0, 1, -1, 1, -1, 0, 1};

    int** dist = (int**)malloc(R * sizeof(int*));
    for (int i = 0; i < R; i++) {
        dist[i] = (int*)malloc(C * sizeof(int));
        for (int j = 0; j < C; j++) {
            dist[i][j] = INT_MAX;
        }
    }

    Queue* q = createQueue(R * C);

    dist[0][0] = 1;
    enqueue(q, 0, 0, 1);

    while (!isEmpty(q)) {
        Cell current = dequeue(q);
        int r = current.r;
        int c = current.c;
        int d = current.dist;

        if (r == R - 1 && c == C - 1) {
            for (int i = 0; i < R; i++) {
                free(dist[i]);
            }
            free(dist);
            freeQueue(q);
            return d;
        }

        for (int i = 0; i < 8; i++) {
            int nr = r + dr[i];
            int nc = c + dc[i];

            if (nr >= 0 && nr < R && nc >= 0 && nc < C && grid[nr][nc] == 0 && d + 1 < dist[nr][nc]) {
                dist[nr][nc] = d + 1;
                enqueue(q, nr, nc, d + 1);
            }
        }
    }

    for (int i = 0; i < R; i++) {
        free(dist[i]);
    }
    free(dist);
    freeQueue(q);
    return -1;
}