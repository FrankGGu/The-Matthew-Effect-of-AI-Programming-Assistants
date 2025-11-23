#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minDifference(int** grid, int gridSize, int* gridColSize, int x, int y) {
    int n = gridSize;
    int m = gridColSize[0];
    int submatrixSize = x;
    int target = y;

    int minDiff = INT_MAX;

    for (int i = 0; i <= n - submatrixSize; i++) {
        for (int j = 0; j <= m - submatrixSize; j++) {
            int count = 0;
            for (int row = i; row < i + submatrixSize; row++) {
                for (int col = j; col < j + submatrixSize; col++) {
                    if (grid[row][col] <= target) {
                        count++;
                    }
                }
            }

            int diff = abs(count - (submatrixSize * submatrixSize - count));
            if (diff < minDiff) {
                minDiff = diff;
            }
        }
    }

    return minDiff;
}