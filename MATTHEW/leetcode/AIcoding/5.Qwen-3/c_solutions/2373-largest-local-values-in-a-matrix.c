#include <stdio.h>
#include <stdlib.h>

int** largestLocal(int** grid, int gridSize, int* gridColSize, int* returnSize, int** returnColumnSizes) {
    int n = gridSize;
    int m = *gridColSize;
    int** result = (int**)malloc((n - 1) * sizeof(int*));
    *returnColumnSizes = (int*)malloc((n - 1) * sizeof(int));
    *returnSize = n - 1;
    for (int i = 0; i < n - 1; i++) {
        result[i] = (int*)malloc((m - 1) * sizeof(int));
        (*returnColumnSizes)[i] = m - 1;
    }
    for (int i = 0; i < n - 1; i++) {
        for (int j = 0; j < m - 1; j++) {
            int maxVal = 0;
            for (int x = i; x < i + 2; x++) {
                for (int y = j; y < j + 2; y++) {
                    if (grid[x][y] > maxVal) {
                        maxVal = grid[x][y];
                    }
                }
            }
            result[i][j] = maxVal;
        }
    }
    return result;
}