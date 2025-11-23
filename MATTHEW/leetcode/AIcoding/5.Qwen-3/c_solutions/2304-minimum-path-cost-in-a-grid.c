#include <stdio.h>
#include <stdlib.h>

int min(int a, int b) {
    return a < b ? a : b;
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

int minPathCost(int** grid, int gridSize, int* gridColSize, int** moveCost, int moveCostSize, int* moveCostColSize) {
    int rows = gridSize;
    int cols = gridColSize[0];
    int** dp = create2DArray(rows, cols);

    for (int j = 0; j < cols; j++) {
        dp[0][j] = grid[0][j];
    }

    for (int i = 1; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            int minCost = INT_MAX;
            for (int k = 0; k < cols; k++) {
                int cost = dp[i-1][k] + moveCost[grid[i-1][k]][j];
                if (cost < minCost) {
                    minCost = cost;
                }
            }
            dp[i][j] = minCost;
        }
    }

    int result = INT_MAX;
    for (int j = 0; j < cols; j++) {
        if (dp[rows-1][j] < result) {
            result = dp[rows-1][j];
        }
    }

    free2DArray(dp, rows);
    return result;
}