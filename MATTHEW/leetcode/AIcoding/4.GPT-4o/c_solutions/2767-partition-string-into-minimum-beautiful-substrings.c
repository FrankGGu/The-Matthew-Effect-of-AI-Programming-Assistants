int minimumBeautifulSubstrings(char * s) {
    int n = strlen(s);
    int dp[n + 1];
    dp[0] = 0;

    for (int i = 1; i <= n; i++) {
        dp[i] = INT_MAX;
        int num = 0;
        for (int j = i; j >= 1; j--) {
            num = (num << 1) | (s[j - 1] - '0');
            if (num > 31) break;
            if (num == 1 || num == 2 || num == 4 || num == 8 || num == 16) {
                dp[i] = fmin(dp[i], dp[j - 1] + 1);
            }
        }
    }

    return dp[n] == INT_MAX ? -1 : dp[n];
}