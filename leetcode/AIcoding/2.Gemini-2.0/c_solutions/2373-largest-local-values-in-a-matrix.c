#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int** largestLocal(int** grid, int gridSize, int* gridColSize, int* returnSize, int** returnColumnSizes){
    int n = gridSize;
    int m = *gridColSize;
    int** result = (int**)malloc((n - 2) * sizeof(int*));
    *returnColumnSizes = (int*)malloc((n - 2) * sizeof(int));
    *returnSize = n - 2;
    for (int i = 0; i < n - 2; i++) {
        result[i] = (int*)malloc((m - 2) * sizeof(int));
        (*returnColumnSizes)[i] = m - 2;
        for (int j = 0; j < m - 2; j++) {
            int maxVal = 0;
            for (int x = i; x < i + 3; x++) {
                for (int y = j; y < j + 3; y++) {
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