#define MOD 1000000007

int numTilings(int N) {
    if (N == 0) return 1;
    if (N == 1) return 1;
    if (N == 2) return 2;

    long long dp[N + 1];
    dp[0] = 1;
    dp[1] = 1;
    dp[2] = 2;

    for (int i = 3; i <= N; i++) {
        dp[i] = (dp[i - 1] + dp[i - 2] * 2) % MOD;
    }

    return dp[N];
}