int waysToReachTarget(int target, int** types, int typesSize, int* typesColSize) {
    int MOD = 1000000007;
    int dp[target + 1];
    for (int i = 0; i <= target; i++) {
        dp[i] = 0;
    }
    dp[0] = 1;

    for (int i = 0; i < typesSize; i++) {
        int count = types[i][0];
        int mark = types[i][1];
        for (int j = target; j >= 0; j--) {
            for (int k = 1; k <= count; k++) {
                if (j - k * mark >= 0) {
                    dp[j] = (dp[j] + dp[j - k * mark]) % MOD;
                }
            }
        }
    }

    return dp[target];
}