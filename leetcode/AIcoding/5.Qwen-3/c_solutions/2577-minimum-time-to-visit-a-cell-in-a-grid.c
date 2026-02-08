#include <stdio.h>
#include <stdlib.h>
#include <limits.h>

typedef struct {
    int x;
    int y;
    int time;
} Node;

typedef struct {
    Node* data;
    int size;
    int capacity;
} PriorityQueue;

int compare(const void* a, const void* b) {
    return ((Node*)a)->time - ((Node*)b)->time;
}

void push(PriorityQueue* pq, Node node) {
    if (pq->size == pq->capacity) {
        pq->capacity *= 2;
        pq->data = (Node*)realloc(pq->data, pq->capacity * sizeof(Node));
    }
    pq->data[pq->size++] = node;
    qsort(pq->data, pq->size, sizeof(Node), compare);
}

Node pop(PriorityQueue* pq) {
    Node min = pq->data[0];
    for (int i = 0; i < pq->size - 1; i++) {
        pq->data[i] = pq->data[i + 1];
    }
    pq->size--;
    return min;
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

int minTimeToVisitCell(int** grid, int gridSize, int* gridColSize) {
    int rows = gridSize;
    int cols = gridColSize[0];
    int** dist = create2DArray(rows, cols);
    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            dist[i][j] = INT_MAX;
        }
    }

    PriorityQueue pq;
    pq.data = (Node*)malloc(sizeof(Node));
    pq.size = 0;
    pq.capacity = 1;

    if (grid[0][0] == 0) {
        dist[0][0] = 0;
        push(&pq, (Node){0, 0, 0});
    } else {
        return -1;
    }

    int dirs[4][2] = {{-1, 0}, {1, 0}, {0, -1}, {0, 1}};
    while (pq.size > 0) {
        Node curr = pop(&pq);
        int x = curr.x;
        int y = curr.y;
        int time = curr.time;

        if (x == rows - 1 && y == cols - 1) {
            free2DArray(dist, rows);
            free(pq.data);
            return time;
        }

        if (time > dist[x][y]) continue;

        for (int d = 0; d < 4; d++) {
            int nx = x + dirs[d][0];
            int ny = y + dirs[d][1];
            if (nx >= 0 && nx < rows && ny >= 0 && ny < cols) {
                int new_time = time + 1;
                if (new_time < dist[nx][ny]) {
                    dist[nx][ny] = new_time;
                    push(&pq, (Node){nx, ny, new_time});
                }
            }
        }
    }

    free2DArray(dist, rows);
    free(pq.data);
    return -1;
}