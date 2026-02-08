/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
int countPathsWithXor(int** grid, int gridSize, int* gridColSize, int k) {
    int m = gridSize, n = gridColSize[0];
    int dp[m][n][16];
    memset(dp, 0, sizeof(dp));

    dp[0][0][grid[0][0]] = 1;

    for (int i = 0; i < m; i++) {
        for (int j = 0; j < n; j++) {
            for (int x = 0; x < 16; x++) {
                if (dp[i][j][x] > 0) {
                    if (i + 1 < m) {
                        int new_xor = x ^ grid[i+1][j];
                        dp[i+1][j][new_xor] = (dp[i+1][j][new_xor] + dp[i][j][x]) % 1000000007;
                    }
                    if (j + 1 < n) {
                        int new_xor = x ^ grid[i][j+1];
                        dp[i][j+1][new_xor] = (dp[i][j+1][new_xor] + dp[i][j][x]) % 1000000007;
                    }
                }
            }
        }
    }

    return dp[m-1][n-1][k];
}