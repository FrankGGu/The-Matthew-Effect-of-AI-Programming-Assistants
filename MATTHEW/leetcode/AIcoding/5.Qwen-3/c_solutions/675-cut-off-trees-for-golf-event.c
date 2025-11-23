#include <stdio.h>
#include <stdlib.h>
#include <limits.h>

typedef struct {
    int x;
    int y;
} Point;

typedef struct {
    Point* data;
    int size;
    int capacity;
} Queue;

Queue* createQueue() {
    Queue* q = (Queue*)malloc(sizeof(Queue));
    q->size = 0;
    q->capacity = 1;
    q->data = (Point*)malloc(q->capacity * sizeof(Point));
    return q;
}

void enqueue(Queue* q, Point p) {
    if (q->size == q->capacity) {
        q->capacity *= 2;
        q->data = (Point*)realloc(q->data, q->capacity * sizeof(Point));
    }
    q->data[q->size++] = p;
}

Point dequeue(Queue* q) {
    Point p = q->data[0];
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

int bfs(int** forest, int rows, int cols, int startRow, int startCol, int endRow, int endCol) {
    int** visited = (int**)malloc(rows * sizeof(int*));
    for (int i = 0; i < rows; i++) {
        visited[i] = (int*)malloc(cols * sizeof(int));
        for (int j = 0; j < cols; j++) {
            visited[i][j] = 0;
        }
    }

    Queue* q = createQueue();
    Point start = {startRow, startCol};
    enqueue(q, start);
    visited[startRow][startCol] = 1;

    int directions[4][2] = {{-1, 0}, {1, 0}, {0, -1}, {0, 1}};
    int steps = 0;

    while (!isEmpty(q)) {
        int levelSize = q->size;
        for (int i = 0; i < levelSize; i++) {
            Point current = dequeue(q);
            if (current.x == endRow && current.y == endCol) {
                for (int i = 0; i < rows; i++) {
                    free(visited[i]);
                }
                free(visited);
                freeQueue(q);
                return steps;
            }
            for (int d = 0; d < 4; d++) {
                int nx = current.x + directions[d][0];
                int ny = current.y + directions[d][1];
                if (nx >= 0 && nx < rows && ny >= 0 && ny < cols && !visited[nx][ny] && forest[nx][ny] > 0) {
                    visited[nx][ny] = 1;
                    enqueue(q, (Point){nx, ny});
                }
            }
        }
        steps++;
    }

    for (int i = 0; i < rows; i++) {
        free(visited[i]);
    }
    free(visited);
    freeQueue(q);
    return -1;
}

int compare(const void* a, const void* b) {
    return ((Point*)a)->x - ((Point*)b)->x;
}

int cutOffTree(int** forest, int forestSize, int* forestColSize) {
    int rows = forestSize;
    int cols = forestColSize[0];

    Point* trees = (Point*)malloc(rows * cols * sizeof(Point));
    int treeCount = 0;

    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            if (forest[i][j] > 0) {
                trees[treeCount++] = (Point){i, j};
            }
        }
    }

    qsort(trees, treeCount, sizeof(Point), compare);

    int totalSteps = 0;
    int prevX = 0;
    int prevY = 0;

    for (int i = 0; i < treeCount; i++) {
        int x = trees[i].x;
        int y = trees[i].y;
        int steps = bfs(forest, rows, cols, prevX, prevY, x, y);
        if (steps == -1) {
            free(trees);
            return -1;
        }
        totalSteps += steps;
        prevX = x;
        prevY = y;
    }

    free(trees);
    return totalSteps;
}