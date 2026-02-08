#include <stdlib.h> // For malloc, free

int min(int a, int b) {
    return a < b ? a : b;
}

int countFertilePyramids(int** grid, int gridSize, int* gridColSize) {
    int m = gridSize;
    int n = gridColSize[0];

    if (m == 0 || n == 0) {
        return 0;
    }

    int totalPyramids = 0;

    // dp_down[r][c] stores the maximum height of a pyramid with apex at (r,c) pointing downwards.
    // A pyramid of height H at (r,c) means grid[r][c] is 1, and the three cells
    // (r+1, c-1), (r+1, c), (r+1, c+1) must each be the apex of a pyramid of height H-1.
    int** dp_down = (int**)malloc(m * sizeof(int*));
    for (int i = 0; i < m; i++) {
        dp_down[i] = (int*)malloc(n * sizeof(int));
    }

    // Calculate dp_down values by iterating from bottom-up
    for (int r = m - 1; r >= 0; r--) {
        for (int c = 0; c < n; c++) {
            if (grid[r][c] == 0) {
                dp_down[r][c] = 0;
            } else {
                // Base case: A single fertile cell forms a pyramid of height 1.
                // If it's on the bottom row or edge columns, it cannot extend downwards to form a larger pyramid.
                if (r == m - 1 || c == 0 || c == n - 1) {
                    dp_down[r][c] = 1;
                } else {
                    // For a pyramid of height H at (r,c), grid[r][c] must be 1,
                    // and the three cells (r+1, c-1), (r+1, c), (r+1, c+1) must each be
                    // the apex of a pyramid of at least height H-1.
                    // So, the current pyramid's height is 1 + the minimum height of the three pyramids below it.
                    dp_down[r][c] = 1 + min(dp_down[r+1][c-1], min(dp_down[r+1][c], dp_down[r+1][c+1]));
                }

                // A pyramid of height H contributes (H-1) to the total count of pyramids
                // that have height greater than 1. (Height 1 pyramids are single cells and usually not counted as "shapes")
                // Example 1 output confirms this interpretation.
                totalPyramids += (dp_down[r][c] - 1);
            }
        }
    }

    // dp_up[r][c] stores the maximum height of an inverted pyramid with apex at (r,c) pointing upwards.
    // The logic is symmetric to dp_down.
    int** dp_up = (int**)malloc(m * sizeof(int*));
    for (int i = 0; i < m; i++) {
        dp_up[i] = (int*)malloc(n * sizeof(int));
    }

    // Calculate dp_up values by iterating from top-down
    for (int r = 0; r < m; r++) {
        for (int c = 0; c < n; c++) {
            if (grid[r][c] == 0) {
                dp_up[r][c] = 0;
            } else {
                // Base case: A single fertile cell forms an inverted pyramid of height 1.
                // If it's on the top row or edge columns, it cannot extend upwards.
                if (r == 0 || c == 0 || c == n - 1) {
                    dp_up[r][c] = 1;
                } else {
                    // Similar to dp_down, an inverted pyramid of height H at (r,c) requires
                    // grid[r][c] to be 1, and the three cells (r-1, c-1), (r-1, c), (r-1, c+1)
                    // must each be the apex of an inverted pyramid of at least height H-1.
                    dp_up[r][c] = 1 + min(dp_up[r-1][c-1], min(dp_up[r-1][c], dp_up[r-1][c+1]));
                }

                // Add (height - 1) to total for inverted pyramids of height > 1.
                totalPyramids += (dp_up[r][c] - 1);
            }
        }
    }

    // Free allocated memory
    for (int i = 0; i < m; i++) {
        free(dp_down[i]);
        free(dp_up[i]);
    }
    free(dp_down);
    free(dp_up);

    return totalPyramids;
}