#include <limits.h> // Required for INT_MAX

int minOperationsToWriteY(int** grid, int gridSize, int* gridColSize) {
    int n = gridSize;
    int mid = n / 2;

    int countY[3] = {0};       // Counts of 0, 1, 2 for cells forming the 'Y'
    int countOther[3] = {0};   // Counts of 0, 1, 2 for cells not forming the 'Y'

    for (int i = 0; i < n; ++i) {
        for (int j = 0; j < n; ++j) {
            int val = grid[i][j];

            // Determine if the current cell (i, j) is part of the 'Y' shape
            // The 'Y' shape consists of:
            // 1. Two diagonal arms from the top to the center (mid, mid):
            //    (i == j || i + j == n - 1) AND i < mid
            // 2. A vertical stem from the center (mid, mid) to the bottom:
            //    j == mid AND i >= mid

            int is_y_cell = 0; // 0 for false, 1 for true
            if ((i < mid && (i == j || i + j == n - 1)) || (i >= mid && j == mid)) {
                is_y_cell = 1;
            }

            if (is_y_cell) {
                countY[val]++;
            } else {
                countOther[val]++;
            }
        }
    }

    int min_ops = INT_MAX;

    // Iterate through all possible values for 'Y' cells (val_y) and 'other' cells (val_other)
    // The values can be 0, 1, or 2.
    for (int val_y = 0; val_y <= 2; ++val_y) {
        for (int val_other = 0; val_other <= 2; ++val_other) {
            // The value for 'Y' cells must be different from the value for 'other' cells
            if (val_y == val_other) {
                continue;
            }

            int current_ops = 0;

            // Calculate operations needed for 'Y' cells:
            // Sum of all 'Y' cells minus the count of 'Y' cells that already have val_y.
            current_ops += (countY[0] + countY[1] + countY[2]) - countY[val_y];

            // Calculate operations needed for 'other' cells:
            // Sum of all 'other' cells minus the count of 'other' cells that already have val_other.
            current_ops += (countOther[0] + countOther[1] + countOther[2]) - countOther[val_other];

            // Update minimum operations found
            if (current_ops < min_ops) {
                min_ops = current_ops;
            }
        }
    }

    return min_ops;
}