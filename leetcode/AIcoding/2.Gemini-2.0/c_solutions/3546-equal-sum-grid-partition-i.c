#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool checkEqualSum(int* row, int rowSize) {
    int totalSum = 0;
    for (int i = 0; i < rowSize; i++) {
        totalSum += row[i];
    }

    if (totalSum % 2 != 0) {
        return false;
    }

    int currentSum = 0;
    for (int i = 0; i < rowSize; i++) {
        currentSum += row[i];
        if (currentSum == totalSum / 2) {
            return true;
        }
    }

    return false;
}

bool equalSumPartition(int** grid, int gridSize, int* gridColSize) {
    for (int i = 0; i < gridSize; i++) {
        if (!checkEqualSum(grid[i], gridColSize[i])) {
            return false;
        }
    }
    return true;
}