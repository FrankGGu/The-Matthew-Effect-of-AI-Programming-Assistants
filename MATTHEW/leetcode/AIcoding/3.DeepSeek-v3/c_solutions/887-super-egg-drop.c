int superEggDrop(int k, int n) {
    int *dp = (int*)malloc((k + 1) * sizeof(int));
    for (int i = 0; i <= k; i++) {
        dp[i] = 0;
    }

    int moves = 0;
    while (dp[k] < n) {
        moves++;
        for (int i = k; i > 0; i--) {
            dp[i] = dp[i] + dp[i - 1] + 1;
        }
    }

    free(dp);
    return moves;
}