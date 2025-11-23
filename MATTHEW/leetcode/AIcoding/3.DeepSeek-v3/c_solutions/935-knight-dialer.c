int knightDialer(int n) {
    if (n == 1) return 10;

    long mod = 1000000007;
    long a = 1, b = 1, c = 1, d = 1;

    for (int i = 2; i <= n; i++) {
        long a_new = (b + c) % mod;
        long b_new = (2 * a) % mod;
        long c_new = (2 * a + d) % mod;
        long d_new = (2 * c) % mod;

        a = a_new;
        b = b_new;
        c = c_new;
        d = d_new;
    }

    long total = (4 * a + 2 * b + 2 * c + d) % mod;
    return (int)total;
}