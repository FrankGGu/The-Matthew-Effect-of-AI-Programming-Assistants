int minChanges(char* s, int k) {
    int n = strlen(s);
    int dp[n+1][k+1];
    for (int i = 0; i <= n; i++) {
        for (int j = 0; j <= k; j++) {
            dp[i][j] = 1000000000;
        }
    }
    dp[0][0] = 0;

    for (int i = 1; i <= n; i++) {
        for (int j = 1; j <= k; j++) {
            for (int len = 1; len <= i; len++) {
                int left = i - len;
                int right = i - 1;
                int cost = 0;
                while (left < right) {
                    if (s[left] != s[right]) cost++;
                    left++;
                    right--;
                }
                if (dp[i - len][j - 1] != 1000000000) {
                    dp[i][j] = fmin(dp[i][j], dp[i - len][j - 1] + cost);
                }
            }
        }
    }
    return dp[n][k];
}