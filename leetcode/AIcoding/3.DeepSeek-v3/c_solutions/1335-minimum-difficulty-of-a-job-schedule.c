int minDifficulty(int* jobDifficulty, int jobDifficultySize, int d) {
    if (d > jobDifficultySize) return -1;

    int n = jobDifficultySize;
    int dp[d][n];

    dp[0][0] = jobDifficulty[0];
    for (int j = 1; j < n; j++) {
        dp[0][j] = (jobDifficulty[j] > dp[0][j-1]) ? jobDifficulty[j] : dp[0][j-1];
    }

    for (int i = 1; i < d; i++) {
        for (int j = i; j < n; j++) {
            int max_val = jobDifficulty[j];
            dp[i][j] = INT_MAX;
            for (int k = j; k >= i; k--) {
                if (jobDifficulty[k] > max_val) {
                    max_val = jobDifficulty[k];
                }
                int prev = dp[i-1][k-1];
                if (prev != INT_MAX && prev + max_val < dp[i][j]) {
                    dp[i][j] = prev + max_val;
                }
            }
        }
    }

    return dp[d-1][n-1];
}