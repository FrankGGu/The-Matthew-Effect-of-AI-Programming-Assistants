#include <stdio.h>
#include <stdlib.h>
#include <math.h>

#define MOD 1000000007

long long fact[141];
long long invFact[141];

long long power(long long base, long long exp) {
    long long res = 1;
    base %= MOD;
    while (exp > 0) {
        if (exp % 2 == 1) res = (res * base) % MOD;
        base = (base * base) % MOD;
        exp /= 2;
    }
    return res;
}

void precompute_factorials(int max_n) {
    fact[0] = 1;
    for (int i = 1; i <= max_n; i++) {
        fact[i] = (fact[i - 1] * i) % MOD;
    }
    invFact[max_n] = power(fact[max_n], MOD - 2); // Fermat's Little Theorem for modular inverse
    for (int i = max_n - 1; i >= 0; i--) {
        invFact[i] = (invFact[i + 1] * (i + 1)) % MOD;
    }
}

long long nCr_mod_p(int n, int r) {
    if (r < 0 || r > n) {
        return 0;
    }
    // C(n, r) = n! / (r! * (n-r)!)
    // = n! * (r!)^(-1) * ((n-r)!)^(-1) (mod MOD)
    long long numerator = fact[n];
    long long denominator = (invFact[r] * invFact[n - r]) % MOD;
    return (numerator * denominator) % MOD;
}

long long countWays(int k, long long P) {
    // Static flag to ensure precomputation happens only once
    static int precomputed = 0;
    if (!precomputed) {
        precompute_factorials(140); // Precompute up to max N for nCr
        precomputed = 1;
    }

    long long ans = 1;
    long long temp_P = P;

    // Iterate through potential prime factors up to sqrt(P)
    for (long long i = 2; i * i <= temp_P; ++i) {
        if (temp_P % i == 0) {
            int exponent = 0;
            while (temp_P % i == 0) {
                exponent++;
                temp_P /= i;
            }
            // For each prime factor p_i with exponent e_i,
            // we need to distribute e_i identical items (factors of p_i) into k distinct bins.
            // This is a stars and bars problem: C(e_i + k - 1, k - 1)
            ans = (ans * nCr_mod_p(exponent + k - 1, k - 1)) % MOD;
        }
    }

    // If temp_P is still greater than 1, it means the remaining temp_P is a prime factor itself
    if (temp_P > 1) {
        int exponent = 1; // Its exponent is 1
        ans = (ans * nCr_mod_p(exponent + k - 1, k - 1)) % MOD;
    }

    return ans;
}