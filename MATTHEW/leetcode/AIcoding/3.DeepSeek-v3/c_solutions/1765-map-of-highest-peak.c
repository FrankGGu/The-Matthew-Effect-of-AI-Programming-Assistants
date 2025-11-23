#include <stdlib.h>

/**
 * Return an array of arrays of size *returnSize.
 * The sizes of the returned arrays are stored in *returnColumnSizes.
 */
int** highestPeak(int** isWater, int isWaterSize, int* isWaterColSize, int* returnSize, int** returnColumnSizes) {
    int m = isWaterSize;
    int n = isWaterColSize[0];

    *returnSize = m;
    *returnColumnSizes = (int*)malloc(m * sizeof(int));
    for (int i = 0; i < m; i++) {
        (*returnColumnSizes)[i] = n;
    }

    int** height = (int**)malloc(m * sizeof(int*));
    for (int i = 0; i < m; i++) {
        height[i] = (int*)malloc(n * sizeof(int));
        for (int j = 0; j < n; j++) {
            height[i][j] = -1;
        }
    }

    int queue[m * n][2];
    int front = 0, rear = 0;

    for (int i = 0; i < m; i++) {
        for (int j = 0; j < n; j++) {
            if (isWater[i][j] == 1) {
                height[i][j] = 0;
                queue[rear][0] = i;
                queue[rear][1] = j;
                rear++;
            }
        }
    }

    int dirs[4][2] = {{0, 1}, {0, -1}, {1, 0}, {-1, 0}};

    while (front < rear) {
        int x = queue[front][0];
        int y = queue[front][1];
        front++;

        for (int k = 0; k < 4; k++) {
            int nx = x + dirs[k][0];
            int ny = y + dirs[k][1];

            if (nx >= 0 && nx < m && ny >= 0 && ny < n && height[nx][ny] == -1) {
                height[nx][ny] = height[x][y] + 1;
                queue[rear][0] = nx;
                queue[rear][1] = ny;
                rear++;
            }
        }
    }

    return height;
}