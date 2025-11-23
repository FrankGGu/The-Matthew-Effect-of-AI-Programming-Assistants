#include <stdio.h>
#include <stdlib.h>
#include <limits.h>

typedef struct {
    int row;
    int col;
} Pair;

typedef struct {
    Pair* data;
    int front;
    int rear;
    int size;
    int capacity;
} Queue;

Queue* createQueue(int capacity) {
    Queue* q = (Queue*)malloc(sizeof(Queue));
    q->capacity = capacity;
    q->front = q->rear = -1;
    q->size = 0;
    q->data = (Pair*)malloc(capacity * sizeof(Pair));
    return q;
}

int isEmpty(Queue* q) {
    return q->size == 0;
}

void enqueue(Queue* q, Pair item) {
    if (q->size == q->capacity) return;
    q->rear = (q->rear + 1) % q->capacity;
    q->data[q->rear] = item;
    q->size++;
}

Pair dequeue(Queue* q) {
    Pair item = q->data[q->front];
    q->front = (q->front + 1) % q->capacity;
    q->size--;
    return item;
}

int** create2DArray(int rows, int cols) {
    int** arr = (int**)malloc(rows * sizeof(int*));
    for (int i = 0; i < rows; i++) {
        arr[i] = (int*)malloc(cols * sizeof(int));
    }
    return arr;
}

void free2DArray(int** arr, int rows) {
    for (int i = 0; i < rows; i++) {
        free(arr[i]);
    }
    free(arr);
}

int min(int a, int b) {
    return a < b ? a : b;
}

int** updateMatrix(int** matrix, int matrixSize, int* matrixColSize, int* returnSize, int** returnColumnSizes) {
    int rows = matrixSize;
    int cols = matrixColSize[0];
    int** result = create2DArray(rows, cols);
    Queue* q = createQueue(rows * cols);

    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            if (matrix[i][j] == 0) {
                result[i][j] = 0;
                enqueue(q, (Pair){i, j});
            } else {
                result[i][j] = INT_MAX;
            }
        }
    }

    int directions[4][2] = {{-1, 0}, {1, 0}, {0, -1}, {0, 1}};

    while (!isEmpty(q)) {
        Pair current = dequeue(q);
        int r = current.row;
        int c = current.col;

        for (int d = 0; d < 4; d++) {
            int nr = r + directions[d][0];
            int nc = c + directions[d][1];

            if (nr >= 0 && nr < rows && nc >= 0 && nc < cols && result[nr][nc] == INT_MAX) {
                result[nr][nc] = result[r][c] + 1;
                enqueue(q, (Pair){nr, nc});
            }
        }
    }

    *returnSize = rows;
    *returnColumnSizes = (int*)malloc(rows * sizeof(int));
    for (int i = 0; i < rows; i++) {
        (*returnColumnSizes)[i] = cols;
    }

    return result;
}