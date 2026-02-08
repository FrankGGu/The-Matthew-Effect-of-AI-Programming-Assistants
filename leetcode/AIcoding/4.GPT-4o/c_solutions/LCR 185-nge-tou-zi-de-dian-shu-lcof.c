double[] calcProbabilities(int n) {
    double dp[1001][1001] = {0};
    double total = 0;

    for (int i = 1; i <= n; i++) {
        dp[i][i] = 1;  // All events are distinct
        total += dp[i][i];
    }

    for (int i = 1; i <= n; i++) {
        for (int j = 0; j < i; j++) {
            dp[i][j] += dp[i-1][j] * (i - 1);  // Choose one from the previous i-1
            dp[i][j+1] += dp[i-1][j];  // New event added
        }
    }

    double *result = (double *)malloc((n + 1) * sizeof(double));
    for (int i = 0; i <= n; i++) {
        result[i] = dp[n][i] / total;  // Normalize the probabilities
    }

    return result;
}