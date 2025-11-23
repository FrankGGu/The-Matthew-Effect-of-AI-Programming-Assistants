#define MOD 1000000007

int dp[101][101];

int countWays(int n, int k) {
    if (n == 0) return 1;
    if (k == 0) return 0;
    if (dp[n][k] != -1) return dp[n][k];

    long long res = 0;
    for (int i = 0; i <= n; i++) {
        res = (res + countWays(n - i - 1, k - 1)) % MOD;
    }

    return dp[n][k] = res;
}

int countArrangements(int n, int k) {
    memset(dp, -1, sizeof(dp));
    return countWays(n, k);
}