#include <stdlib.h>
#include <string.h>
#include <limits.h>

int max(int a, int b) {
    return a > b ? a : b;
}

int cherryPickup(int** grid, int gridSize, int* gridColSize) {
    int N = gridSize;
    int MAX_STEPS = 2 * N - 2;

    int*** dp = (int***)malloc((MAX_STEPS + 1) * sizeof(int**));
    for (int k = 0; k <= MAX_STEPS; ++k) {
        dp[k] = (int**)malloc(N * sizeof(int*));
        for (int r1 = 0; r1 < N; ++r1) {
            dp[k][r1] = (int*)malloc(N * sizeof(int));
            for (int r2 = 0; r2 < N; ++r2) {
                dp[k][r1][r2] = -1;
            }
        }
    }

    if (grid[0][0] == -1) {
        dp[0][0][0] = -1;
    } else {
        dp[0][0][0] = grid[0][0];
    }

    for (int k = 1; k <= MAX_STEPS; ++k) {
        for (int r1 = 0; r1 < N; ++r1) {
            int c1 = k - r1;
            if (c1 < 0 || c1 >= N || grid[r1][c1] == -1) {
                continue;
            }

            for (int r2 = 0; r2 < N; ++r2) {
                int c2 = k - r2;
                if (c2 < 0 || c2 >= N || grid[r2][c2] == -1) {
                    continue;
                }

                int current_cherries = grid[r1][c1];
                if (r1 != r2 || c1 != c2) {
                    current_cherries += grid[r2][c2];
                }

                int max_prev_cherries = -1;

                // Case 1: R1 from (r1-1, c1), R2 from (r2-1, c2)
                if (r1 > 0 && r2 > 0 && dp[k - 1][r1 - 1][r2 - 1] != -1) {
                    max_prev_cherries = max(max_prev_cherries, dp[k - 1][r1 - 1][r2 - 1]);
                }
                // Case 2: R1 from (r1-1, c1), R2 from (r2, c2-1)
                if (r1 > 0 && c2 > 0 && dp[k - 1][r1 - 1][r2] != -1) {
                    max_prev_cherries = max(max_prev_cherries, dp[k - 1][r1 - 1][r2]);
                }
                // Case 3: R1 from (r1, c1-1), R2 from (r2-1, c2)
                if (c1 > 0 && r2 > 0 && dp[k - 1][r1][r2 - 1] != -1) {
                    max_prev_cherries = max(max_prev_cherries, dp[k - 1][r1][r2 - 1]);
                }
                // Case 4: R1 from (r1, c1-1), R2 from (r2, c2-1)
                if (c1 > 0 && c2 > 0 && dp[k - 1][r1][r2] != -1) {
                    max_prev_cherries = max(max_prev_cherries, dp[k - 1][r1][r2]);
                }

                if (max_prev_cherries != -1) {
                    dp[k][r1][r2] = max_prev_cherries + current_cherries;
                }
            }
        }
    }

    int result = dp[MAX_STEPS][N - 1][N - 1];
    if (result == -1) {
        result = 0;
    }

    for (int k = 0; k <= MAX_STEPS; ++k) {
        for (int r1 = 0; r1 < N; ++r1) {
            free(dp[k][r1]);
        }
        free(dp[k]);
    }
    free(dp);

    return result;
}