int countOrders(int n) {
    long long ans = 1;
    long long MOD = 1000000007;

    for (int i = 1; i <= n; ++i) {
        ans = (ans * i) % MOD;
        ans = (ans * (2 * i - 1)) % MOD;
    }

    return (int)ans;
}