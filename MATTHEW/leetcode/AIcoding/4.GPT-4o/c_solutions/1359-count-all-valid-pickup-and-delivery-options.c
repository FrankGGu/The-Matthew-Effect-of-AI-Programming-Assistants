#define MOD 1000000007

int countOrders(int n) {
    long long dp = 1;
    for (int i = 1; i <= n; i++) {
        dp = dp * (2 * i - 1) % MOD * i % MOD;
    }
    return dp;
}