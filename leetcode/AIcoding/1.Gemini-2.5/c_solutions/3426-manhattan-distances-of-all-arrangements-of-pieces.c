#include <stdio.h>

long long MOD = 1000000007;

long long power(long long base, long long exp) {
    long long res = 1;
    base %= MOD;
    while (exp > 0) {
        if (exp % 2 == 1) {
            res = (res * base) % MOD;
        }
        base = (base * base) % MOD;
        exp /= 2;
    }
    return res;
}

long long modInverse(long long n) {
    return power(n, MOD - 2);
}

long long nCr_mod_p(long long n, long long r) {
    if (r < 0 || r > n) {
        return 0;
    }
    if (r == 0 || r == n) {
        return 1;
    }
    if (r > n / 2) {
        r = n - r;
    }

    long long res = 1;
    for (long long i = 1; i <= r; ++i) {
        res = (res * (n - i + 1)) % MOD;
        res = (res * modInverse(i)) % MOD;
    }
    return res;
}

int sumDistance(int n, int k) {
    if (k < 2) {
        return 0;
    }

    long long N_plus_1 = (long long)n + 1;
    long long C_n_plus_1_3 = nCr_mod_p(N_plus_1, 3);

    long long N_minus_2 = (long long)n - 2;
    long long K_minus_2 = (long long)k - 2;
    long long C_n_minus_2_k_minus_2 = nCr_mod_p(N_minus_2, K_minus_2);

    long long result = (C_n_plus_1_3 * C_n_minus_2_k_minus_2) % MOD;

    return (int)result;
}