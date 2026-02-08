#include <stdlib.h>

int max(int a, int b) {
    return a > b ? a : b;
}

int min(int a, int b) {
    return a < b ? a : b;
}

int maxIncreaseKeepingSkyline(int** grid, int gridSize, int* gridColSize) {
    int n = gridSize;

    int* rowMax = (int*)malloc(n * sizeof(int));
    int* colMax = (int*)malloc(n * sizeof(int));

    for (int i = 0; i < n; i++) {
        rowMax[i] = 0;
        colMax[i] = 0;
    }

    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            rowMax[i] = max(rowMax[i], grid[i][j]);
            colMax[j] = max(colMax[j], grid[i][j]);
        }
    }

    int totalIncrease = 0;

    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            totalIncrease += (min(rowMax[i], colMax[j]) - grid[i][j]);
        }
    }

    free(rowMax);
    free(colMax);

    return totalIncrease;
}