#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool isPrintable(int** targetGrid, int targetGridSize, int* targetGridColSize, int color) {
    int minRow = targetGridSize, maxRow = -1;
    int minCol = targetGridColSize[0], maxCol = -1;

    for (int i = 0; i < targetGridSize; i++) {
        for (int j = 0; j < targetGridColSize[0]; j++) {
            if (targetGrid[i][j] == color) {
                minRow = (minRow < i) ? minRow : i;
                maxRow = (maxRow > i) ? maxRow : i;
                minCol = (minCol < j) ? minCol : j;
                maxCol = (maxCol > j) ? maxCol : j;
            }
        }
    }

    if (maxRow == -1) return true;

    for (int i = minRow; i <= maxRow; i++) {
        for (int j = minCol; j <= maxCol; j++) {
            if (targetGrid[i][j] != color && targetGrid[i][j] != 0) {
                return false;
            }
        }
    }

    for (int i = minRow; i <= maxRow; i++) {
        for (int j = minCol; j <= maxCol; j++) {
            if (targetGrid[i][j] == color) {
                targetGrid[i][j] = 0;
            }
        }
    }

    return true;
}

bool isPrintable2(int** targetGrid, int targetGridSize, int* targetGridColSize) {
    int colors[61] = {0};
    for (int i = 0; i < targetGridSize; i++) {
        for (int j = 0; j < targetGridColSize[0]; j++) {
            colors[targetGrid[i][j]] = 1;
        }
    }

    int count = 0;
    for (int i = 1; i <= 60; i++) {
        if (colors[i]) count++;
    }

    while (count > 0) {
        int found = 0;
        for (int i = 1; i <= 60; i++) {
            if (colors[i] && isPrintable(targetGrid, targetGridSize, targetGridColSize, i)) {
                colors[i] = 0;
                count--;
                found = 1;
            }
        }
        if (found == 0) return false;
    }
    return true;
}