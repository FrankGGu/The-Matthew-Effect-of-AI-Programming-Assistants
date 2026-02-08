#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool checkGrid(int** grid, int gridSize, int* gridColSize) {
    int m = gridSize;
    int n = gridColSize[0];

    int totalSum = 0;
    for (int i = 0; i < m; i++) {
        for (int j = 0; j < n; j++) {
            totalSum += grid[i][j];
        }
    }

    if (totalSum == 0) return true;

    for (int col = 1; col < n; col++) {
        int leftSum = 0;
        for (int i = 0; i < m; i++) {
            for (int j = 0; j < col; j++) {
                leftSum += grid[i][j];
            }
        }
        if (leftSum != 0 && leftSum != totalSum) return true;
    }

    for (int row = 1; row < m; row++) {
        int topSum = 0;
        for (int i = 0; i < row; i++) {
            for (int j = 0; j < n; j++) {
                topSum += grid[i][j];
            }
        }
        if (topSum != 0 && topSum != totalSum) return true;
    }

    return false;
}