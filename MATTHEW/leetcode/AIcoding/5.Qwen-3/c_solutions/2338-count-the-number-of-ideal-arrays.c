#include <stdio.h>
#include <stdlib.h>
#include <math.h>

#define MOD 1000000007

long long mod_pow(long long base, long long exp, long long mod) {
    long long result = 1;
    base = base % mod;
    while (exp > 0) {
        if (exp % 2 == 1)
            result = (result * base) % mod;
        base = (base * base) % mod;
        exp /= 2;
    }
    return result;
}

long long comb(int n, int k) {
    if (k > n || k < 0) return 0;
    long long numerator = 1;
    for (int i = 0; i < k; i++) {
        numerator = numerator * (n - i) % MOD;
    }
    long long denominator = 1;
    for (int i = 1; i <= k; i++) {
        denominator = denominator * i % MOD;
    }
    return numerator * mod_pow(denominator, MOD - 2, MOD) % MOD;
}

int countIdealArrays(int n, int m) {
    int max_val = m;
    int* prime_factors = (int*)malloc((max_val + 1) * sizeof(int));
    for (int i = 0; i <= max_val; i++) prime_factors[i] = 0;

    for (int i = 2; i <= max_val; i++) {
        if (prime_factors[i] == 0) {
            for (int j = i; j <= max_val; j += i) {
                prime_factors[j]++;
            }
        }
    }

    long long result = 0;
    for (int i = 1; i <= m; i++) {
        int k = prime_factors[i];
        result = (result + comb(n - 1, k)) % MOD;
    }

    free(prime_factors);
    return (int)result;
}