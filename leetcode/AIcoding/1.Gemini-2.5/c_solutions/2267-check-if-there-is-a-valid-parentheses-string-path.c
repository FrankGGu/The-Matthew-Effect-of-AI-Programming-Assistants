#include <stdbool.h>
#include <string.h> // For memset, if needed, but direct loop initialization is fine

bool hasValidPath(char** grid, int gridSize, int* gridColSize) {
    int m = gridSize;
    int n = gridColSize[0];

    if ((m + n - 1) % 2 != 0) {
        return false;
    }

    int MAX_BALANCE = m + n - 1;
    bool dp[m][n][MAX_BALANCE + 1];

    for (int i = 0; i < m; ++i) {
        for (int j = 0; j < n; ++j) {
            for (int k = 0; k < MAX_BALANCE + 1; ++k) {
                dp[i][j][k] = false;
            }
        }
    }

    if (grid[0][0] == '(') {
        dp[0][0][1] = true;
    } else {
        return false;
    }

    for (int r = 0; r < m; ++r) {
        for (int c = 0; c < n; ++c) {
            if (r == 0 && c == 0) continue;

            int change = (grid[r][c] == '(') ? 1 : -1;

            for (int bal = 0; bal <= MAX_BALANCE; ++bal) {
                int prev_bal = bal - change;

                if (prev_bal >= 0 && prev_bal <= MAX_BALANCE) {
                    if (r > 0 && dp[r-1][c][prev_bal]) {
                        dp[r][c][bal] = true;
                    }
                    if (c > 0 && dp[r][c-1][prev_bal]) {
                        dp[r][c][bal] = true;
                    }
                }
            }
        }
    }

    return dp[m-1][n-1][0];
}