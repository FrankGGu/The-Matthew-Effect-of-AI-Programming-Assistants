long long power(long long base, long long exp) {
    long long res = 1;
    long long mod = 1000000007;
    base %= mod;
    while (exp > 0) {
        if (exp % 2 == 1) res = (res * base) % mod;
        base = (base * base) % mod;
        exp /= 2;
    }
    return res;
}

long long modInverse(long long n) {
    long long mod = 1000000007;
    return power(n, mod - 2);
}

long long nCr_mod_p(int n_val, int r_val) {
    long long mod = 1000000007;
    if (r_val < 0 || r_val > n_val) return 0;
    if (r_val == 0 || r_val == n_val) return 1;
    if (r_val > n_val / 2) r_val = n_val - r_val;

    long long num = 1;
    for (int i = 0; i < r_val; ++i) {
        num = (num * (n_val - i)) % mod;
    }

    long long den = 1;
    for (int i = 1; i <= r_val; ++i) {
        den = (den * i) % mod;
    }

    return (num * modInverse(den)) % mod;
}

int numberOfSets(int n, int k) {
    int N_val = n + 1;
    int K_val = 2 * k;

    return (int)nCr_mod_p(N_val, K_val);
}