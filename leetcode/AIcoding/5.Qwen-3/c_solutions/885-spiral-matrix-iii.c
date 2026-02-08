#include <stdio.h>
#include <stdlib.h>

int** spiralMatrixIII(int m, int n, int k, int* returnSize, int** returnColumnSizes) {
    int** result = (int**)malloc(m * n * sizeof(int*));
    *returnColumnSizes = (int*)malloc(m * n * sizeof(int));
    *returnSize = 0;

    int x = 0, y = 0;
    int dx[] = {0, 1, 0, -1};
    int dy[] = {1, 0, -1, 0};
    int dir = 0;
    int steps = 1;
    int count = 0;

    while (count < k) {
        for (int i = 0; i < 2; i++) {
            for (int j = 0; j < steps; j++) {
                if (x >= 0 && x < m && y >= 0 && y < n) {
                    result[*returnSize] = (int*)malloc(2 * sizeof(int));
                    result[*returnSize][0] = x;
                    result[*returnSize][1] = y;
                    (*returnSize)++;
                }
                x += dx[dir];
                y += dy[dir];
                count++;
                if (count == k) break;
            }
            dir = (dir + 1) % 4;
        }
        steps++;
    }

    for (int i = 0; i < *returnSize; i++) {
        (*returnColumnSizes)[i] = 2;
    }

    return result;
}