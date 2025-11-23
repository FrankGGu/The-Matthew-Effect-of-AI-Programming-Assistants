int numberOfWays(int startPos, int endPos, int k) {
    int diff = abs(startPos - endPos);
    if (diff > k || (k - diff) % 2 != 0) return 0;

    int MOD = 1000000007;
    int n = (k - diff) / 2;
    int m = diff + n;

    long long *dp = (long long*)calloc(n + 1, sizeof(long long));
    dp[0] = 1;

    for (int i = 1; i <= k; i++) {
        for (int j = n; j > 0; j--) {
            dp[j] = (dp[j] + dp[j - 1]) % MOD;
        }
    }

    long long result = dp[n];
    free(dp);
    return result;
}