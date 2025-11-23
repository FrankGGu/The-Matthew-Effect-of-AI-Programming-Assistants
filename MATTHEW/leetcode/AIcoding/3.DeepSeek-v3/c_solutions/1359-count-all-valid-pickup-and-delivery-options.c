int countOrders(int n) {
    long long res = 1;
    long long mod = 1000000007;

    for (int i = 1; i <= n; i++) {
        res = res * i % mod;
        res = res * (2 * i - 1) % mod;
    }

    return (int)res;
}