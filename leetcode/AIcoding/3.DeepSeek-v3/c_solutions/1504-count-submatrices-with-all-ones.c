int numSubmat(int** mat, int matSize, int* matColSize) {
    int m = matSize;
    int n = matColSize[0];
    int dp[m][n];
    memset(dp, 0, sizeof(dp));

    for (int i = 0; i < m; i++) {
        for (int j = 0; j < n; j++) {
            if (mat[i][j] == 1) {
                dp[i][j] = (j == 0) ? 1 : dp[i][j-1] + 1;
            }
        }
    }

    int count = 0;
    for (int i = 0; i < m; i++) {
        for (int j = 0; j < n; j++) {
            int minWidth = dp[i][j];
            for (int k = i; k >= 0; k--) {
                if (dp[k][j] == 0) break;
                minWidth = (minWidth < dp[k][j]) ? minWidth : dp[k][j];
                count += minWidth;
            }
        }
    }

    return count;
}