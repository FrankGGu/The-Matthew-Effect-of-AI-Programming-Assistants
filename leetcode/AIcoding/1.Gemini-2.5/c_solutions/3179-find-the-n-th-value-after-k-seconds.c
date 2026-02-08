#include <stdlib.h>

long long power(long long base, long long exp) {
    long long res = 1;
    long long MOD = 1000000007;
    base %= MOD;
    while (exp > 0) {
        if (exp % 2 == 1) res = (res * base) % MOD;
        base = (base * base) % MOD;
        exp /= 2;
    }
    return res;
}

long long modInverse(long long n) {
    long long MOD = 1000000007;
    return power(n, MOD - 2);
}

long long nCr_mod_p(int n_val, int r_val) {
    if (r_val < 0 || r_val > n_val) return 0;
    if (r_val == 0 || r_val == n_val) return 1;
    if (r_val > n_val / 2) r_val = n_val - r_val;

    long long MOD = 1000000007;

    static long long fact[2001];
    static int fact_init = 0;

    if (!fact_init) {
        fact[0] = 1;
        for (int i = 1; i <= 2000; i++) { // Max n_val is 1000 + 1000 - 1 = 1999
            fact[i] = (fact[i - 1] * i) % MOD;
        }
        fact_init = 1;
    }

    long long numerator = fact[n_val];
    long long denominator = (fact[r_val] * fact[n_val - r_val]) % MOD;

    return (numerator * modInverse(denominator)) % MOD;
}

int findNthValue(int n, int k) {
    int N_comb = k + n - 1;
    int K_comb = k;

    return (int)nCr_mod_p(N_comb, K_comb);
}