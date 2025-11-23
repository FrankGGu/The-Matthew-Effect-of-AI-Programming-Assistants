#define MAX(a, b) ((a) > (b) ? (a) : (b))
#define MIN(a, b) ((a) < (b) ? (a) : (b))

long long maxScore(int** grid, int gridSize, int* gridColSize) {
    int m = gridSize, n = gridColSize[0];
    long long dp[m][n];

    for (int i = 0; i < m; i++) {
        for (int j = 0; j < n; j++) {
            dp[i][j] = -1e18;
        }
    }

    dp[m-1][n-1] = grid[m-1][n-1];

    for (int i = m-1; i >= 0; i--) {
        for (int j = n-1; j >= 0; j--) {
            if (i == m-1 && j == n-1) continue;

            if (i < m-1) {
                dp[i][j] = MAX(dp[i][j], dp[i+1][j] + grid[i][j]);
            }
            if (j < n-1) {
                dp[i][j] = MAX(dp[i][j], dp[i][j+1] + grid[i][j]);
            }
        }
    }

    long long res = -1e18;
    for (int i = 0; i < m; i++) {
        for (int j = 0; j < n; j++) {
            long long val = dp[i][j];
            if (i < m-1) val = MAX(val, dp[i][j] - grid[i][j] + grid[i+1][j]);
            if (j < n-1) val = MAX(val, dp[i][j] - grid[i][j] + grid[i][j+1]);
            res = MAX(res, val);
        }
    }

    return res;
}