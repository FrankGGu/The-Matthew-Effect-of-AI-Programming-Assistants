int minimumOperations(char* leaves) {
    int n = strlen(leaves);
    int dp[n][3];
    dp[0][0] = (leaves[0] == 'y');
    dp[0][1] = dp[0][2] = n + 1;

    for (int i = 1; i < n; i++) {
        int isRed = (leaves[i] == 'r');
        int isYellow = (leaves[i] == 'y');

        dp[i][0] = dp[i-1][0] + isYellow;
        dp[i][1] = fmin(dp[i-1][0], dp[i-1][1]) + isRed;
        if (i >= 2) {
            dp[i][2] = fmin(dp[i-1][1], dp[i-1][2]) + isYellow;
        } else {
            dp[i][2] = n + 1;
        }
    }

    return dp[n-1][2];
}