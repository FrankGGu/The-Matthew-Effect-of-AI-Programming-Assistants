#include <stdlib.h> // For malloc, free

static inline int min(int a, int b) {
    return a < b ? a : b;
}

int largest1BorderedSquare(int** grid, int gridSize, int* gridColSize) {
    if (gridSize == 0 || gridColSize[0] == 0) {
        return 0;
    }

    int rows = gridSize;
    int cols = gridColSize[0];

    // left[r][c]: number of consecutive 1s to the left of (r, c) including (r, c)
    // up[r][c]: number of consecutive 1s upwards from (r, c) including (r, c)
    int** left = (int**)malloc(rows * sizeof(int*));
    int** up = (int**)malloc(rows * sizeof(int*));
    for (int i = 0; i < rows; ++i) {
        left[i] = (int*)malloc(cols * sizeof(int));
        up[i] = (int*)malloc(cols * sizeof(int));
    }

    // Populate DP arrays
    for (int r = 0; r < rows; ++r) {
        for (int c = 0; c < cols; ++c) {
            if (grid[r][c] == 1) {
                left[r][c] = (c > 0) ? left[r][c-1] + 1 : 1;
                up[r][c] = (r > 0) ? up[r-1][c] + 1 : 1;
            } else {
                left[r][c] = 0;
                up[r][c] = 0;
            }
        }
    }

    int max_side = 0;

    // Iterate through all possible bottom-right corners (r, c)
    for (int r = 0; r < rows; ++r) {
        for (int c = 0; c < cols; ++c) {
            // The maximum possible side length 'k' for a square ending at (r, c)
            // is limited by the minimum of consecutive 1s to its left and above.
            int k_limit = min(left[r][c], up[r][c]);

            // Iterate 'k' downwards from k_limit to 1
            // This ensures that the first 'k' found will be the largest for this (r, c)
            for (int k = k_limit; k >= 1; --k) {
                // For a square of side 'k' with bottom-right at (r, c),
                // its top-left corner is at (r - k + 1, c - k + 1).
                // We need to check if the top border and left border also have length 'k'.
                // Top border check: left[r - k + 1][c] >= k
                // Left border check: up[r][c - k + 1] >= k
                if (left[r - k + 1][c] >= k && up[r][c - k + 1] >= k) {
                    if (k > max_side) {
                        max_side = k;
                    }
                    // Since we are iterating 'k' downwards,
                    // the first valid 'k' is the largest for current (r, c).
                    // We can break and move to the next (r, c).
                    break; 
                }
            }
        }
    }

    // Free allocated memory
    for (int i = 0; i < rows; ++i) {
        free(left[i]);
        free(up[i]);
    }
    free(left);
    free(up);

    return max_side * max_side;
}