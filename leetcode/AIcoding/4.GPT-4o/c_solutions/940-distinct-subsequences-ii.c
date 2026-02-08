#define MOD 1000000007

int distinctSubseqII(char * s) {
    int last[256] = {0};
    long long dp[100001] = {0};
    int n = strlen(s);

    dp[0] = 1;

    for (int i = 1; i <= n; i++) {
        dp[i] = (2 * dp[i - 1]) % MOD;
        if (last[s[i - 1]] != 0) {
            dp[i] = (dp[i] - dp[last[s[i - 1]] - 1] + MOD) % MOD;
        }
        last[s[i - 1]] = i;
    }

    return (dp[n] - 1 + MOD) % MOD;
}