int numSubmat(int** mat, int matSize, int* matColSize) {
    int result = 0;
    int dp[matSize][*matColSize];

    for (int i = 0; i < matSize; i++) {
        for (int j = 0; j < *matColSize; j++) {
            if (mat[i][j] == 1) {
                dp[i][j] = (i == 0 ? 0 : dp[i - 1][j]) + 1;
            } else {
                dp[i][j] = 0;
            }
        }
    }

    for (int i = 0; i < matSize; i++) {
        for (int j = 0; j < *matColSize; j++) {
            if (dp[i][j] > 0) {
                int minHeight = dp[i][j];
                for (int k = j; k >= 0; k--) {
                    if (dp[i][k] == 0) break;
                    minHeight = fmin(minHeight, dp[i][k]);
                    result += minHeight;
                }
            }
        }
    }

    return result;
}