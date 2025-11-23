#include <stdio.h>
#include <stdlib.h>

typedef __int128_t int128;

int128 max128(int128 a, int128 b) {
    return a > b ? a : b;
}

int128 min128(int128 a, int128 b) {
    return a < b ? a : b;
}

long long maxProductPath(int** grid, int gridSize, int* gridColSize) {
    int m = gridSize;
    int n = gridColSize[0];

    // dp_max[i][j] stores the maximum product path ending at (i, j)
    // dp_min[i][j] stores the minimum product path ending at (i, j)
    // We need both because multiplying by a negative number flips max/min.
    int128 dp_max[m][n];
    int128 dp_min[m][n];

    long long MOD = 1000000007;

    // Base case: (0,0)
    dp_max[0][0] = grid[0][0];
    dp_min[0][0] = grid[0][0];

    // Fill the first row
    for (int j = 1; j < n; j++) {
        int128 val = grid[0][j];
        int128 p1 = dp_max[0][j-1] * val;
        int128 p2 = dp_min[0][j-1] * val;
        dp_max[0][j] = max128(p1, p2);
        dp_min[0][j] = min128(p1, p2);
    }

    // Fill the first column
    for (int i = 1; i < m; i++) {
        int128 val = grid[i][0];
        int128 p1 = dp_max[i-1][0] * val;
        int128 p2 = dp_min[i-1][0] * val;
        dp_max[i][0] = max128(p1, p2);
        dp_min[i][0] = min128(p1, p2);
    }

    // Fill the rest of the DP table
    for (int i = 1; i < m; i++) {
        for (int j = 1; j < n; j++) {
            int128 val = grid[i][j];

            int128 max_from_up, min_from_up;
            int128 max_from_left, min_from_left;

            // Calculate products if coming from the cell above (i-1, j)
            max_from_up = dp_max[i-1][j] * val;
            min_from_up = dp_min[i-1][j] * val;

            // Calculate products if coming from the cell to the left (i, j-1)
            max_from_left = dp_max[i][j-1] * val;
            min_from_left = dp_min[i][j-1] * val;

            // Update dp_max and dp_min based on the sign of the current cell's value
            if (val >= 0) {
                // If current value is non-negative, max product comes from max * val, min product from min * val
                dp_max[i][j] = max128(max_from_up, max_from_left);
                dp_min[i][j] = min128(min_from_up, min_from_left);
            } else { // val < 0
                // If current value is negative, max product comes from min * val, min product from max * val
                dp_max[i][j] = max128(min_from_up, min_from_left);
                dp_min[i][j] = min128(max_from_up, max_from_left);
            }
        }
    }

    int128 final_product = dp_max[m-1][n-1];

    if (final_product < 0) {
        return -1;
    } else {
        return (long long)(final_product % MOD);
    }
}