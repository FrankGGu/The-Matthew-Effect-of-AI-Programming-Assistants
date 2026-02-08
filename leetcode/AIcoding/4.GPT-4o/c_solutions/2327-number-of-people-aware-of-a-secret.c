#define MOD 1000000007

int peopleAwareOfSecret(int n, int delay, int forget) {
    long long dp[n + 1];
    for (int i = 0; i <= n; i++) {
        dp[i] = 0;
    }
    dp[1] = 1;
    long long total = 0;

    for (int i = 1; i <= n; i++) {
        if (i >= delay) {
            total = (total + dp[i - delay]) % MOD;
        }
        if (i >= forget) {
            total = (total - dp[i - forget] + MOD) % MOD;
        }
        dp[i + 1] = total;
    }

    long long result = 0;
    for (int i = n - forget + 1; i <= n; i++) {
        result = (result + dp[i]) % MOD;
    }

    return (int)result;
}