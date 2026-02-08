int maxTraining(int n, int m, int* gain, int* loss) {
    int dp[m + 1];
    for (int i = 0; i <= m; i++) {
        dp[i] = 0;
    }
    for (int i = 0; i < n; i++) {
        for (int j = m; j >= loss[i]; j--) {
            dp[j] = fmax(dp[j], dp[j - loss[i]] + gain[i]);
        }
    }
    return dp[m];
}