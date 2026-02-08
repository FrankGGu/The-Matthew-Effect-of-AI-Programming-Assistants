int minDifficulty(int* jobDifficulty, int jobSize, int d) {
    if (jobSize < d) return -1;

    int dp[jobSize + 1][d + 1];
    for (int i = 0; i <= jobSize; i++) {
        for (int j = 0; j <= d; j++) {
            dp[i][j] = INT_MAX;
        }
    }

    dp[0][0] = 0;

    for (int j = 1; j <= d; j++) {
        for (int i = j; i <= jobSize; i++) {
            int maxDifficulty = 0;
            for (int k = i; k >= j; k--) {
                maxDifficulty = fmax(maxDifficulty, jobDifficulty[k - 1]);
                dp[i][j] = fmin(dp[i][j], dp[k - 1][j - 1] + maxDifficulty);
            }
        }
    }

    return dp[jobSize][d];
}