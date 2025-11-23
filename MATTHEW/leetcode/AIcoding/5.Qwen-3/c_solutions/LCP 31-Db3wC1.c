#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

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
    q->data = (Point*)malloc(sizeof(Point) * q->capacity);
    return q;
}

void enqueue(Queue* q, Point p) {
    if (q->size == q->capacity) {
        q->capacity *= 2;
        q->data = (Point*)realloc(q->data, sizeof(Point) * q->capacity);
    }
    q->data[q->size++] = p;
}

Point dequeue(Queue* q) {
    return q->data[--q->size];
}

bool isEmpty(Queue* q) {
    return q->size == 0;
}

void freeQueue(Queue* q) {
    free(q->data);
    free(q);
}

int** visited;
int rows, cols;

bool isValid(int x, int y, int** maze) {
    return x >= 0 && x < rows && y >= 0 && y < cols && !visited[x][y] && maze[x][y] == 0;
}

int solve(int** maze, int mazeSize, int* mazeColSize, int x, int y, int entranceX, int entranceY) {
    rows = mazeSize;
    cols = mazeColSize[0];
    visited = (int**)malloc(rows * sizeof(int*));
    for (int i = 0; i < rows; i++) {
        visited[i] = (int*)calloc(cols, sizeof(int));
    }

    Queue* q = createQueue();
    Point start = {entranceX, entranceY};
    enqueue(q, start);
    visited[entranceX][entranceY] = 1;

    int steps = 0;
    int directions[4][2] = {{-1, 0}, {1, 0}, {0, -1}, {0, 1}};

    while (!isEmpty(q)) {
        int levelSize = q->size;
        for (int i = 0; i < levelSize; i++) {
            Point current = dequeue(q);
            if (current.x == x && current.y == y) {
                freeQueue(q);
                for (int i = 0; i < rows; i++) {
                    free(visited[i]);
                }
                free(visited);
                return steps;
            }
            for (int d = 0; d < 4; d++) {
                int nx = current.x + directions[d][0];
                int ny = current.y + directions[d][1];
                if (isValid(nx, ny, maze)) {
                    visited[nx][ny] = 1;
                    enqueue(q, (Point){nx, ny});
                }
            }
        }
        steps++;
    }

    freeQueue(q);
    for (int i = 0; i < rows; i++) {
        free(visited[i]);
    }
    free(visited);
    return -1;
}