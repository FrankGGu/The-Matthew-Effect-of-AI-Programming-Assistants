int findRotateSteps(char *ring, char *key) {
    int m = strlen(ring), n = strlen(key);
    int dp[n + 1][m];
    memset(dp, 0x3f, sizeof(dp));

    for (int j = 0; j < m; j++)
        for (int i = 0; i < m; i++)
            if (ring[i] == key[j])
                dp[j + 1][i] = 1 + (j == 0 ? 0 : dp[j][i]);

    for (int j = 1; j <= n; j++) {
        for (int i = 0; i < m; i++) {
            for (int k = 0; k < m; k++) {
                if (ring[k] == key[j - 1]) {
                    int steps = abs(k - i);
                    steps = steps < m - steps ? steps : m - steps;
                    dp[j][k] = fmin(dp[j][k], dp[j - 1][i] + steps + 1);
                }
            }
        }
    }

    int res = INT_MAX;
    for (int i = 0; i < m; i++) {
        res = fmin(res, dp[n][i]);
    }

    return res;
}