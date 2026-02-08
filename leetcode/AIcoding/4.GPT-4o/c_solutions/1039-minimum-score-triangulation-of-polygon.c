int minScoreTriangulation(int* A, int ASize) {
    int dp[ASize][ASize];
    for (int i = 0; i < ASize; i++) {
        for (int j = 0; j < ASize; j++) {
            dp[i][j] = 0;
        }
    }

    for (int length = 2; length < ASize; length++) {
        for (int i = 0; i < ASize - length; i++) {
            int j = i + length;
            dp[i][j] = INT_MAX;
            for (int k = i + 1; k < j; k++) {
                int score = A[i] * A[k] * A[j] + dp[i][k] + dp[k][j];
                if (score < dp[i][j]) {
                    dp[i][j] = score;
                }
            }
        }
    }

    return dp[0][ASize - 1];
}