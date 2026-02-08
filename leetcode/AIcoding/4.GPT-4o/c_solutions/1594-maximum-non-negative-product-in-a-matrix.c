#define MOD 1000000007

int maxProductPath(int** grid, int gridSize, int* gridColSize) {
    long long dp[gridSize][*gridColSize];
    long long maxProd = 1;
    int hasNegative = 0;

    for (int i = 0; i < gridSize; i++) {
        for (int j = 0; j < *gridColSize; j++) {
            if (grid[i][j] < 0) hasNegative = 1;
            if (i == 0 && j == 0) {
                dp[i][j] = grid[i][j];
            } else {
                long long maxPath = 0, minPath = 0;
                if (i > 0) {
                    maxPath = dp[i - 1][j];
                    minPath = dp[i - 1][j];
                }
                if (j > 0) {
                    maxPath = fmax(maxPath, dp[i][j - 1]);
                    minPath = fmin(minPath, dp[i][j - 1]);
                }
                if (grid[i][j] >= 0) {
                    dp[i][j] = fmax(0, maxPath * grid[i][j]);
                } else {
                    dp[i][j] = fmin(minPath * grid[i][j], 0);
                }
            }
        }
    }

    if (dp[gridSize - 1][*gridColSize - 1] < 0) return -1;

    return (int)(dp[gridSize - 1][*gridColSize - 1] % MOD);
}