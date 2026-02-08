#include <stdlib.h>

typedef struct {
    int r;
    int c;
} Point;

#define MAX_QUEUE_SIZE 10000

Point queue[MAX_QUEUE_SIZE];
int front = 0;
int rear = 0;

void enqueue(int r, int c) {
    queue[rear].r = r;
    queue[rear].c = c;
    rear = (rear + 1) % MAX_QUEUE_SIZE;
}

Point dequeue() {
    Point p = queue[front];
    front = (front + 1) % MAX_QUEUE_SIZE;
    return p;
}

int is_queue_empty() {
    return front == rear;
}

int** highestPeak(int** isWater, int isWaterSize, int* isWaterColSize, int* returnSize, int** returnColumnSizes) {
    int m = isWaterSize;
    int n = isWaterColSize[0];

    // Allocate memory for the result matrix
    int** result = (int**)malloc(m * sizeof(int*));
    *returnColumnSizes = (int*)malloc(m * sizeof(int));
    for (int i = 0; i < m; i++) {
        result[i] = (int*)malloc(n * sizeof(int));
        (*returnColumnSizes)[i] = n;
    }
    *returnSize = m;

    // Initialize queue and result matrix
    front = 0;
    rear = 0;

    for (int i = 0; i < m; i++) {
        for (int j = 0; j < n; j++) {
            if (isWater[i][j] == 1) {
                result[i][j] = 0;
                enqueue(i, j); // Add all water cells to the queue
            } else {
                result[i][j] = -1; // Mark land cells as unvisited
            }
        }
    }

    // Directions for neighbors (up, down, left, right)
    int dr[] = {-1, 1, 0, 0};
    int dc[] = {0, 0, -1, 1};

    // BFS traversal
    while (!is_queue_empty()) {
        Point current = dequeue();
        int r = current.r;
        int c = current.c;

        for (int i = 0; i < 4; i++) {
            int nr = r + dr[i];
            int nc = c + dc[i];

            // Check bounds
            if (nr >= 0 && nr < m && nc >= 0 && nc < n) {
                // If the neighbor is an unvisited land cell
                if (result[nr][nc] == -1) {
                    result[nr][nc] = result[r][c] + 1;
                    enqueue(nr, nc);
                }
            }
        }
    }

    return result;
}