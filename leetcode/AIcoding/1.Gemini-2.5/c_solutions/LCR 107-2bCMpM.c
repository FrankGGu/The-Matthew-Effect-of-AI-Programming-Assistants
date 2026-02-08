#include <stdlib.h>

typedef struct {
    int r;
    int c;
} Cell;

typedef struct {
    Cell* data;
    int front;
    int rear;
    int capacity;
} Queue;

Queue* createQueue(int capacity) {
    Queue* q = (Queue*)malloc(sizeof(Queue));
    q->capacity = capacity;
    q->front = 0;
    q->rear = -1;
    q->data = (Cell*)malloc(sizeof(Cell) * capacity);
    return q;
}

void enqueue(Queue* q, int r, int c) {
    q->rear = (q->rear + 1);
    q->data[q->rear].r = r;
    q->data[q->rear].c = c;
}

Cell dequeue(Queue* q) {
    Cell cell = q->data[q->front];
    q->front = (q->front + 1);
    return cell;
}

int isQueueEmpty(Queue* q) {
    return q->front > q->rear;
}

void freeQueue(Queue* q) {
    free(q->data);
    free(q);
}

int dr[] = {-1, 1, 0, 0};
int dc[] = {0, 0, -1, 1};

int** updateMatrix(int** mat, int matSize, int* matColSize, int* returnSize, int** returnColumnSizes) {
    int m = matSize;
    int n = matColSize[0];

    int** result = (int**)malloc(sizeof(int*) * m);
    *returnColumnSizes = (int*)malloc(sizeof(int) * m);
    for (int i = 0; i < m; i++) {
        result[i] = (int*)malloc(sizeof(int) * n);
        (*returnColumnSizes)[i] = n;
    }
    *returnSize = m;

    Queue* q = createQueue(m * n);

    for (int i = 0; i < m; i++) {
        for (int j = 0; j < n; j++) {
            if (mat[i][j] == 0) {
                result[i][j] = 0;
                enqueue(q, i, j);
            } else {
                result[i][j] = -1;
            }
        }
    }

    while (!isQueueEmpty(q)) {
        Cell current = dequeue(q);
        int r = current.r;
        int c = current.c;

        for (int i = 0; i < 4; i++) {
            int nr = r + dr[i];
            int nc = c + dc[i];

            if (nr >= 0 && nr < m && nc >= 0 && nc < n) {
                if (result[nr][nc] == -1) {
                    result[nr][nc] = result[r][c] + 1;
                    enqueue(q, nr, nc);
                }
            }
        }
    }

    freeQueue(q);

    return result;
}