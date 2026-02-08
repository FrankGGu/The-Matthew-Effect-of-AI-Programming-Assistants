#include <stdbool.h>

bool satisfiesConditions(int** grid, int gridSize, int* gridColSize) {
    int m = gridSize;
    int n = gridColSize[0];

    for (int r = 0; r < m; r++) {
        for (int c = 0; c < n; c++) {
            // Condition 1: All elements in the same row must be equal.
            // Check if the current element is equal to the element to its left.
            if (c > 0) {
                if (grid[r][c] != grid[r][c-1]) {
                    return false;
                }
            }

            // Condition 2: All elements in the same column must be strictly increasing.
            // Check if the current element is strictly greater than the element above it.
            if (r > 0) {
                if (grid[r][c] <= grid[r-1][c]) {
                    return false;
                }
            }
        }
    }

    return true;
}