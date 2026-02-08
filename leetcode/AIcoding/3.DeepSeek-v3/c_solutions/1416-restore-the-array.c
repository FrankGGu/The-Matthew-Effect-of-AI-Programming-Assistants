int numberOfArrays(char* s, int k) {
    int n = strlen(s);
    int mod = 1e9 + 7;
    long long* dp = (long long*)malloc((n + 1) * sizeof(long long));
    for (int i = 0; i <= n; i++) {
        dp[i] = 0;
    }
    dp[n] = 1;

    for (int i = n - 1; i >= 0; i--) {
        if (s[i] == '0') {
            dp[i] = 0;
            continue;
        }
        long long num = 0;
        for (int j = i; j < n; j++) {
            num = num * 10 + (s[j] - '0');
            if (num > k) break;
            dp[i] = (dp[i] + dp[j + 1]) % mod;
        }
    }

    int result = dp[0];
    free(dp);
    return result;
}