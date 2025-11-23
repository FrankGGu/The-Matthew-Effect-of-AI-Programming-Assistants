#include <stdio.h>
#include <stdlib.h>

int** updateMatrix(int** matrix, int matrixSize, int* matrixColSize, int* returnSize, int** returnColumnSizes) {
    int m = matrixSize;
    int n = matrixColSize[0];
    int** dist = (int**)malloc(m * sizeof(int*));
    for (int i = 0; i < m; i++) {
        dist[i] = (int*)malloc(n * sizeof(int));
    }

    int qSize = m * n;
    int* queue = (int*)malloc(qSize * 2 * sizeof(int));
    int front = 0, rear = 0;

    for (int i = 0; i < m; i++) {
        for (int j = 0; j < n; j++) {
            if (matrix[i][j] == 0) {
                queue[rear++] = i;
                queue[rear++] = j;
                dist[i][j] = 0;
            } else {
                dist[i][j] = INT_MAX;
            }
        }
    }

    int dirs[4][2] = {{-1, 0}, {1, 0}, {0, -1}, {0, 1}};

    while (front < rear) {
        int x = queue[front++];
        int y = queue[front++;
        for (int k = 0; k < 4; k++) {
            int nx = x + dirs[k][0];
            int ny = y + dirs[k][1];
            if (nx >= 0 && nx < m && ny >= 0 && ny < n && dist[nx][ny] == INT_MAX) {
                dist[nx][ny] = dist[x][y] + 1;
                queue[rear++] = nx;
                queue[rear++] = ny;
            }
        }
    }

    *returnSize = m;
    *returnColumnSizes = (int*)malloc(m * sizeof(int));
    for (int i = 0; i < m; i++) {
        (*returnColumnSizes)[i] = n;
    }

    free(queue);
    return dist;
}