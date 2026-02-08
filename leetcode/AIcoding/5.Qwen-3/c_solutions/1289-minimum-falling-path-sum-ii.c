#include <stdio.h>
#include <stdlib.h>

int minFallingPathSum(int** grid, int gridSize, int* gridColSize) {
    int n = gridSize;
    for (int i = 1; i < n; i++) {
        int min1 = INT_MAX, min2 = INT_MAX;
        int idx1 = -1;
        for (int j = 0; j < n; j++) {
            if (grid[i-1][j] < min1) {
                min2 = min1;
                min1 = grid[i-1][j];
                idx1 = j;
            } else if (grid[i-1][j] < min2) {
                min2 = grid[i-1][j];
            }
        }
        for (int j = 0; j < n; j++) {
            if (j != idx1) {
                grid[i][j] += min1;
            } else {
                grid[i][j] += min2;
            }
        }
    }
    int result = INT_MAX;
    for (int j = 0; j < n; j++) {
        if (grid[n-1][j] < result) {
            result = grid[n-1][j];
        }
    }
    return result;
}