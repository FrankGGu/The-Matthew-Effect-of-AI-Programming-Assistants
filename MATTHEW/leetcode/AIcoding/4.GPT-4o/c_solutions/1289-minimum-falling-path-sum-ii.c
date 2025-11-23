int minFallingPathSum(int** A, int ASize, int* AColSize) {
    int n = ASize;
    int m = *AColSize;
    int dp[n][m];
    for (int j = 0; j < m; j++) {
        dp[0][j] = A[0][j];
    }
    for (int i = 1; i < n; i++) {
        for (int j = 0; j < m; j++) {
            dp[i][j] = A[i][j];
            int minVal = INT_MAX;
            for (int k = 0; k < m; k++) {
                if (k != j) {
                    minVal = fmin(minVal, dp[i - 1][k]);
                }
            }
            dp[i][j] += minVal;
        }
    }
    int result = INT_MAX;
    for (int j = 0; j < m; j++) {
        result = fmin(result, dp[n - 1][j]);
    }
    return result;
}