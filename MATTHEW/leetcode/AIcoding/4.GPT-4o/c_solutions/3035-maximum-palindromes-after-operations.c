int maxPalindromes(char * s, int k) {
    int n = strlen(s), count = 0;
    int dp[n + 1];
    memset(dp, 0, sizeof(dp));

    for (int i = 0; i < n; i++) {
        for (int j = i; j >= 0; j--) {
            if (s[i] == s[j]) {
                int len = i - j + 1;
                if (len >= k) {
                    dp[i + 1] = fmax(dp[i + 1], dp[j] + 1);
                }
            }
        }
    }

    return dp[n];
}