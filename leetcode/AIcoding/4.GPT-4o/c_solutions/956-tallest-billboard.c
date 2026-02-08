int tallestBillboard(int* rods, int rodsSize) {
    int dp[10001] = {0};
    for (int i = 0; i < rodsSize; i++) {
        int rod = rods[i];
        for (int j = 10000 - rod; j >= 0; j--) {
            if (dp[j] >= 0) {
                dp[j + rod] = dp[j + rod] > dp[j] ? dp[j + rod] : dp[j] + j;
                dp[j] = dp[j] > dp[j - rod] + j ? dp[j] : dp[j - rod] + j;
            }
        }
    }
    return dp[0];
}