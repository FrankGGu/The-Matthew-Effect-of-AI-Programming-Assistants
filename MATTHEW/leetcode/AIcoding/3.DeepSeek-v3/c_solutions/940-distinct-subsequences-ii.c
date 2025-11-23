int distinctSubseqII(char* s) {
    int mod = 1000000007;
    int n = strlen(s);
    long long dp[n + 1];
    int last[26];
    memset(last, -1, sizeof(last));

    dp[0] = 1;

    for (int i = 1; i <= n; i++) {
        dp[i] = (2 * dp[i - 1]) % mod;
        if (last[s[i - 1] - 'a'] != -1) {
            dp[i] = (dp[i] - dp[last[s[i - 1] - 'a']] + mod) % mod;
        }
        last[s[i - 1] - 'a'] = i - 1;
    }

    return (dp[n] - 1) % mod;
}