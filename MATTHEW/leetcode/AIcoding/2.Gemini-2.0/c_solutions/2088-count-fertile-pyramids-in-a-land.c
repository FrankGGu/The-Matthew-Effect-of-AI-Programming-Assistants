#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int countPyramids(int** grid, int gridSize, int* gridColSize) {
    int m = gridSize, n = gridColSize[0];
    int dp[m][n];
    int ans = 0;

    for (int i = 0; i < m; i++) {
        for (int j = 0; j < n; j++) {
            dp[i][j] = grid[i][j];
        }
    }

    for (int i = 1; i < m; i++) {
        for (int j = 1; j < n - 1; j++) {
            if (grid[i][j] == 1) {
                dp[i][j] = 1 + fmin(fmin(dp[i - 1][j - 1], dp[i - 1][j]), dp[i - 1][j + 1]);
            }
        }
    }

    for (int i = 0; i < m; i++) {
        for (int j = 0; j < n; j++) {
            ans += dp[i][j];
        }
    }

    int dp2[m][n];
    for (int i = 0; i < m; i++) {
        for (int j = 0; j < n; j++) {
            dp2[i][j] = grid[i][j];
        }
    }

    for (int i = m - 2; i >= 0; i--) {
        for (int j = 1; j < n - 1; j++) {
            if (grid[i][j] == 1) {
                dp2[i][j] = 1 + fmin(fmin(dp2[i + 1][j - 1], dp2[i + 1][j]), dp2[i + 1][j + 1]);
            }
        }
    }

    for (int i = 0; i < m; i++) {
        for (int j = 0; j < n; j++) {
            ans += dp2[i][j];
        }
    }

    int count = 0;
     for (int i = 0; i < m; i++) {
        for (int j = 0; j < n; j++) {
            if(grid[i][j] == 1){
                count++;
            }
        }
    }
    return ans - count;
}