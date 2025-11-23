int getLengthOfOptimalCompression(char *s, int k) {
    int n = strlen(s);
    int dp[n + 1][k + 1];
    memset(dp, 0x3f, sizeof(dp));
    dp[0][0] = 0;

    for (int i = 1; i <= n; i++) {
        for (int j = 0; j <= k; j++) {
            int count[128] = {0};
            for (int l = i; l >= 1; l--) {
                if (count[s[l - 1]]++ == 0) {
                    int len = i - l + 1;
                    int newJ = j - (i - l + 1 - 1);
                    if (newJ >= 0) {
                        int extra = 0;
                        for (int m = 1; m <= 9; m++) {
                            if (count[s[l - 1]] == m) {
                                extra = 1;
                                break;
                            }
                        }
                        if (count[s[l - 1]] == 1) extra = 1;
                        dp[i][j] = fmin(dp[i][j], dp[l - 1][newJ] + extra);
                    }
                }
            }
        }
    }
    int res = INT_MAX;
    for (int j = 0; j <= k; j++) {
        res = fmin(res, dp[n][j]);
    }
    return res;
}