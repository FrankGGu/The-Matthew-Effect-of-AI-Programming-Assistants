int maxUncrossedLines(int* A, int ASize, int* B, int BSize) {
    int dp[ASize + 1][BSize + 1];
    for (int i = 0; i <= ASize; i++) {
        for (int j = 0; j <= BSize; j++) {
            if (i == 0 || j == 0) {
                dp[i][j] = 0;
            } else if (A[i - 1] == B[j - 1]) {
                dp[i][j] = dp[i - 1][j - 1] + 1;
            } else {
                dp[i][j] = (dp[i - 1][j] > dp[i][j - 1]) ? dp[i - 1][j] : dp[i][j - 1];
            }
        }
    }
    return dp[ASize][BSize];
}