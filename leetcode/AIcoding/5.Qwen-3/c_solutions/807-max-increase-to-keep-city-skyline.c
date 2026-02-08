#include <stdio.h>
#include <stdlib.h>

int** getSkyline(int** grid, int gridSize, int* gridColSize, int* returnSize, int** returnColumnSizes) {
    int n = gridSize;
    int m = *gridColSize;
    int* rowMax = (int*)malloc(n * sizeof(int));
    int* colMax = (int*)malloc(m * sizeof(int));

    for (int i = 0; i < n; i++) {
        rowMax[i] = 0;
        for (int j = 0; j < m; j++) {
            if (grid[i][j] > rowMax[i]) {
                rowMax[i] = grid[i][j];
            }
        }
    }

    for (int j = 0; j < m; j++) {
        colMax[j] = 0;
        for (int i = 0; i < n; i++) {
            if (grid[i][j] > colMax[j]) {
                colMax[j] = grid[i][j];
            }
        }
    }

    int** result = (int**)malloc(n * sizeof(int*));
    *returnColumnSizes = (int*)malloc(n * sizeof(int));
    *returnSize = n * m;

    for (int i = 0; i < n; i++) {
        result[i] = (int*)malloc(m * sizeof(int));
        (*returnColumnSizes)[i] = m;
        for (int j = 0; j < m; j++) {
            result[i][j] = (rowMax[i] < colMax[j]) ? rowMax[i] : colMax[j];
        }
    }

    return result;
}