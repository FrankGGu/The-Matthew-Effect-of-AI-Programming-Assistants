int minimumBeautifulSubstrings(char* s) {
    int n = strlen(s);
    if (s[0] == '0') return -1;

    int dp[n + 1];
    for (int i = 0; i <= n; i++) dp[i] = n + 1;
    dp[0] = 0;

    for (int i = 1; i <= n; i++) {
        if (s[i - 1] == '0') continue;

        long long num = 0;
        for (int j = i; j <= n; j++) {
            num = (num << 1) + (s[j - 1] - '0');
            if (num > 15625) break;

            if ((15625 % num == 0) && dp[i - 1] != n + 1) {
                dp[j] = (dp[j] < dp[i - 1] + 1) ? dp[j] : dp[i - 1] + 1;
            }
        }
    }

    return dp[n] == n + 1 ? -1 : dp[n];
}