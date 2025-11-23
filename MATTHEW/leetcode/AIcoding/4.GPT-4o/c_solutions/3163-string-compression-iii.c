int getLengthOfOptimalCompression(char *s, int k) {
    int n = strlen(s);
    int dp[n + 1][k + 1]; 
    memset(dp, 0x3f, sizeof(dp));
    dp[0][0] = 0;

    for (int i = 1; i <= n; i++) {
        for (int j = 0; j <= k; j++) {
            int count[128] = {0};
            for (int l = i; l >= 1; l--) {
                count[s[l - 1]]++;
                if (count[s[l - 1]] > j) break;

                int remain = j - count[s[l - 1]] + (count[s[l - 1]] > 1 ? (count[s[l - 1]] > 9 ? 2 : 1) : 0);
                dp[i][j] = fmin(dp[i][j], dp[l - 1][remain] + 1 + (count[s[l - 1]] > 1 ? (count[s[l - 1]] > 9 ? 2 : 1) : 0));
            }
        }
    }

    int ans = INT_MAX;
    for (int j = 0; j <= k; j++) {
        ans = fmin(ans, dp[n][j]);
    }

    return ans;
}