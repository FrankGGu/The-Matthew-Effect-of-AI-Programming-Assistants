int minimumOperations(int* leaves, int leavesSize) {
    int dp[leavesSize][3];
    for (int i = 0; i < leavesSize; i++) {
        for (int j = 0; j < 3; j++) {
            dp[i][j] = INT_MAX;
        }
    }

    dp[0][0] = leaves[0] == 1 ? 0 : 1;

    for (int i = 1; i < leavesSize; i++) {
        dp[i][0] = dp[i - 1][0] + (leaves[i] == 1 ? 0 : 1);
        if (i >= 2) {
            dp[i][1] = dp[i - 1][0] + (leaves[i] == 2 ? 0 : 1);
            dp[i][1] = fmin(dp[i][1], dp[i - 1][1] + (leaves[i] == 2 ? 0 : 1));
            dp[i][1] = fmin(dp[i][1], dp[i - 1][2] + (leaves[i] == 2 ? 0 : 1));
        }
        if (i >= 3) {
            dp[i][2] = dp[i - 1][1] + (leaves[i] == 3 ? 0 : 1);
            dp[i][2] = fmin(dp[i][2], dp[i - 1][2] + (leaves[i] == 3 ? 0 : 1));
        }
    }

    return dp[leavesSize - 1][2];
}