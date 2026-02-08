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

bool hasPath(int** grid, int rows, int cols, int startRow, int startCol, int endRow, int endCol) {
    bool** visited = (bool**)malloc(rows * sizeof(bool*));
    for (int i = 0; i < rows; i++) {
        visited[i] = (bool*)malloc(cols * sizeof(bool));
        for (int j = 0; j < cols; j++) {
            visited[i][j] = false;
        }
    }

    Queue* q = createQueue();
    Pair start = {startRow, startCol};
    enqueue(q, start);
    visited[startRow][startCol] = true;

    int directions[4][2] = {{-1, 0}, {1, 0}, {0, -1}, {0, 1}};

    while (!isEmpty(q)) {
        Pair current = dequeue(q);
        if (current.row == endRow && current.col == endCol) {
            freeQueue(q);
            for (int i = 0; i < rows; i++) {
                free(visited[i]);
            }
            free(visited);
            return true;
        }

        for (int i = 0; i < 4; i++) {
            int newRow = current.row + directions[i][0];
            int newCol = current.col + directions[i][1];
            if (newRow >= 0 && newRow < rows && newCol >= 0 && newCol < cols &&
                !visited[newRow][newCol] && grid[newRow][newCol] == 1) {
                visited[newRow][newCol] = true;
                Pair next = {newRow, newCol};
                enqueue(q, next);
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

bool isPossible(int** grid, int rows, int cols) {
    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            if (grid[i][j] == 1) {
                int** tempGrid = (int**)malloc(rows * sizeof(int*));
                for (int k = 0; k < rows; k++) {
                    tempGrid[k] = (int*)malloc(cols * sizeof(int));
                    for (int l = 0; l < cols; l++) {
                        tempGrid[k][l] = grid[k][l];
                    }
                }
                tempGrid[i][j] = 0;
                if (!hasPath(tempGrid, rows, cols, 0, 0, rows - 1, cols - 1)) {
                    for (int k = 0; k < rows; k++) {
                        free(tempGrid[k]);
                    }
                    free(tempGrid);
                    return true;
                }
                for (int k = 0; k < rows; k++) {
                    free(tempGrid[k]);
                }
                free(tempGrid);
            }
        }
    }
    return false;
}

bool isPossibleToBreakPath(int** grid, int gridSize, int* gridColSize) {
    return isPossible(grid, gridSize, gridColSize[0]);
}