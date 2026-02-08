#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

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

bool isEmpty(Queue* q) {
    return q->size == 0;
}

void freeQueue(Queue* q) {
    free(q->data);
    free(q);
}

int dx[] = {-1, 0, 1, 0};
int dy[] = {0, 1, 0, -1};

bool canCross(int** grid, int rows, int cols, int day) {
    int** visited = (int**)malloc(rows * sizeof(int*));
    for (int i = 0; i < rows; i++) {
        visited[i] = (int*)calloc(cols, sizeof(int));
    }

    Queue* q = createQueue();

    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            if (grid[i][j] <= day) {
                visited[i][j] = 1;
                if (i == 0) {
                    enqueue(q, (Pair){i, j});
                }
            }
        }
    }

    while (!isEmpty(q)) {
        Pair current = dequeue(q);
        int x = current.row;
        int y = current.col;

        if (x == rows - 1) {
            freeQueue(q);
            for (int i = 0; i < rows; i++) {
                free(visited[i]);
            }
            free(visited);
            return true;
        }

        for (int i = 0; i < 4; i++) {
            int nx = x + dx[i];
            int ny = y + dy[i];

            if (nx >= 0 && nx < rows && ny >= 0 && ny < cols && !visited[nx][ny] && grid[nx][ny] > day) {
                visited[nx][ny] = 1;
                enqueue(q, (Pair){nx, ny});
            }
        }
    }

    freeQueue(q);
    for (int i = 0; i < rows; i++) {
        free(visited[i]);
    }
    free(visited);
    return false;
}

int binarySearch(int** grid, int rows, int cols) {
    int left = 0;
    int right = rows * cols;
    int answer = 0;

    while (left <= right) {
        int mid = (left + right) / 2;
        if (canCross(grid, rows, cols, mid)) {
            answer = mid;
            left = mid + 1;
        } else {
            right = mid - 1;
        }
    }

    return answer;
}

int latestDayToCross(int** grid, int gridSize, int* gridColSize) {
    return binarySearch(grid, gridSize, *gridColSize);
}