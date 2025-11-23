int stoneGameII(int* piles, int pilesSize) {
    int dp[pilesSize + 1][pilesSize + 1];
    memset(dp, 0, sizeof(dp));

    for (int i = pilesSize - 1; i >= 0; i--) {
        for (int m = 1; m <= pilesSize; m++) {
            int total = 0;
            for (int x = 1; x <= 2 * m && i + x - 1 < pilesSize; x++) {
                total += piles[i + x - 1];
                dp[i][m] = fmax(dp[i][m], total - dp[i + x][fmax(m, x)]);
            }
        }
    }

    return dp[0][1];
}