#include <stdbool.h>
#include <string.h>

int maxMoves(int** grid, int gridSize, int* gridColSize) {
    int m = gridSize;
    int n = gridColSize[0];

    bool dp[m][n];
    memset(dp, 0, sizeof(dp));

    for (int r = 0; r < m; ++r) {
        dp[r][0] = true;
    }

    int max_moves = 0;

    for (int c = 1; c < n; ++c) {
        bool current_col_has_reachable_cell = false;
        for (int r = 0; r < m; ++r) {
            bool reachable_from_prev_col = false;

            if (r > 0 && dp[r-1][c-1] && grid[r][c] > grid[r-1][c-1]) {
                reachable_from_prev_col = true;
            }
            if (dp[r][c-1] && grid[r][c] > grid[r][c-1]) {
                reachable_from_prev_col = true;
            }
            if (r < m - 1 && dp[r+1][c-1] && grid[r][c] > grid[r+1][c-1]) {
                reachable_from_prev_col = true;
            }

            dp[r][c] = reachable_from_prev_col;

            if (dp[r][c]) {
                current_col_has_reachable_cell = true;
            }
        }

        if (current_col_has_reachable_cell) {
            max_moves = c;
        } else {
            break;
        }
    }

    return max_moves;
}