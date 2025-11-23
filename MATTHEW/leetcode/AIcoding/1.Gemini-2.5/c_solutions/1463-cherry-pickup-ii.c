#include <stdlib.h>
#include <string.h>

int max(int a, int b) {
    return a > b ? a : b;
}

int cherryPickup(int** grid, int gridSize, int* gridColSize) {
    int rows = gridSize;
    int cols = gridColSize[0];

    int*** dp = (int***)malloc(rows * sizeof(int**));
    for (int r = 0; r < rows; ++r) {
        dp[r] = (int**)malloc(cols * sizeof(int*));
        for (int c1 = 0; c1 < cols; ++c1) {
            dp[r][c1] = (int*)malloc(cols * sizeof(int));
            for (int c2 = 0; c2 < cols; ++c2) {
                dp[r][c1][c2] = -1;
            }
        }
    }

    dp[0][0][cols - 1] = grid[0][0];
    if (0 != cols - 1) {
        dp[0][0][cols - 1] += grid[0][cols - 1];
    }

    for (int r = 0; r < rows - 1; ++r) {
        for (int c1 = 0; c1 < cols; ++c1) {
            for (int c2 = 0; c2 < cols; ++c2) {
                if (dp[r][c1][c2] == -1) {
                    continue;
                }

                for (int next_c1_delta = -1; next_c1_delta <= 1; ++next_c1_delta) {
                    int next_c1 = c1 + next_c1_delta;

                    if (next_c1 < 0 || next_c1 >= cols) {
                        continue;
                    }

                    for (int next_c2_delta = -1; next_c2_delta <= 1; ++next_c2_delta) {
                        int next_c2 = c2 + next_c2_delta;

                        if (next_c2 < 0 || next_c2 >= cols) {
                            continue;
                        }

                        int cherries_at_next_row = grid[r + 1][next_c1];
                        if (next_c1 != next_c2) {
                            cherries_at_next_row += grid[r + 1][next_c2];
                        }

                        int current_total_cherries = dp[r][c1][c2] + cherries_at_next_row;
                        dp[r + 1][next_c1][next_c2] = max(dp[r + 1][next_c1][next_c2], current_total_cherries);
                    }
                }
            }
        }
    }

    int max_cherries = 0;
    for (int c1 = 0; c1 < cols; ++c1) {
        for (int c2 = 0; c2 < cols; ++c2) {
            max_cherries = max(max_cherries, dp[rows - 1][c1][c2]);
        }
    }

    for (int r = 0; r < rows; ++r) {
        for (int c1 = 0; c1 < cols; ++c1) {
            free(dp[r][c1]);
        }
        free(dp[r]);
    }
    free(dp);

    return max_cherries;
}