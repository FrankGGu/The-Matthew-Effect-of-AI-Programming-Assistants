#include <stdio.h>
#include <stdlib.h>
#include <limits.h>

int* getBiggestThree(int** grid, int gridSize, int* gridColSize, int* returnSize) {
    int rows = gridSize;
    int cols = gridColSize[0];
    int* result = (int*)malloc(3 * sizeof(int));
    int idx = 0;

    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            int maxLen = (int)fmin(i, j, rows - 1 - i, cols - 1 - j);
            for (int k = 0; k <= maxLen; k++) {
                int sum = 0;
                int x = i - k;
                int y = j;
                for (int m = 0; m < 2 * k + 1; m++) {
                    sum += grid[x][y];
                    if (m < k) {
                        x++;
                        y--;
                    } else {
                        x--;
                        y++;
                    }
                }
                if (idx < 3) {
                    result[idx++] = sum;
                } else {
                    int minVal = INT_MAX;
                    int minIdx = -1;
                    for (int l = 0; l < 3; l++) {
                        if (result[l] < minVal) {
                            minVal = result[l];
                            minIdx = l;
                        }
                    }
                    if (sum > minVal) {
                        result[minIdx] = sum;
                    }
                }
            }
        }
    }

    for (int i = 0; i < 3; i++) {
        for (int j = i + 1; j < 3; j++) {
            if (result[i] < result[j]) {
                int temp = result[i];
                result[i] = result[j];
                result[j] = temp;
            }
        }
    }

    *returnSize = 3;
    return result;
}