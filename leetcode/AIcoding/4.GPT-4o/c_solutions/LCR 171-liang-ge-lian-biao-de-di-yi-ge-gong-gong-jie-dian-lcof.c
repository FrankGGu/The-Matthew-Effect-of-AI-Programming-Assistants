int minDifficulty(int* jobDifficulty, int jobSize, int d) {
    if (jobSize < d) return -1;

    int dp[d + 1][jobSize + 1];
    for (int i = 0; i <= d; i++) {
        for (int j = 0; j <= jobSize; j++) {
            dp[i][j] = INT_MAX;
        }
    }

    dp[0][0] = 0;

    for (int i = 1; i <= d; i++) {
        for (int j = i; j <= jobSize; j++) {
            int maxDiff = 0;
            for (int k = j; k >= i; k--) {
                maxDiff = fmax(maxDiff, jobDifficulty[k - 1]);
                dp[i][j] = fmin(dp[i][j], dp[i - 1][k - 1] + maxDiff);
            }
        }
    }

    return dp[d][jobSize];
}