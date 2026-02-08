long long maximumXorProduct(long long a, long long b, int n) {
    long long mod = 1e9 + 7;
    long long x = 0;

    for (int i = n - 1; i >= 0; i--) {
        long long bit = 1LL << i;
        int a_bit = (a & bit) ? 1 : 0;
        int b_bit = (b & bit) ? 1 : 0;

        if (a_bit == b_bit) {
            x |= bit;
        } else {
            if (a > b) {
                long long temp = a;
                a = b;
                b = temp;
            }
            if ((a & bit) == 0) {
                a |= bit;
                b &= ~bit;
            }
        }
    }

    return (a % mod) * (b % mod) % mod;
}