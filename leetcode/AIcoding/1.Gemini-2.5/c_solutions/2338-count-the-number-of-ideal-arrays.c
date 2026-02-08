#include <stdlib.h> // For malloc and free

#define MOD 1000000007

long long* fact;
long long* invFact;

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

long long modInverse(long long n) {
    return power(n, MOD - 2);
}

void precompute_factorials(int max_val) {
    fact = (long long*)malloc((max_val + 1) * sizeof(long long));
    invFact = (long long*)malloc((max_val + 1) * sizeof(long long));

    fact[0] = 1;
    invFact[0] = 1;
    for (int i = 1; i <= max_val; i++) {
        fact[i] = (fact[i - 1] * i) % MOD;
        invFact[i] = modInverse(fact[i]);
    }
}

long long nCr_mod_p(int n_val, int r_val) {
    if (r_val < 0 || r_val > n_val) return 0;
    return (((fact[n_val] * invFact[r_val]) % MOD) * invFact[n_val - r_val]) % MOD;
}

int countIdealArrays(int n, int maxValue) {
    // Max exponent for a prime factor in any number up to maxValue (e.g., 2^13 = 8192, 2^14 = 16384)
    // So max_e is around 13-14.
    // The maximum value for N in nCr(N, K) is (max_e + n - 1).
    // For n=10000, max_e=13, this is 13 + 10000 - 1 = 10012.
    int max_fact_val = n + 13; 
    precompute_factorials(max_fact_val);

    long long total_ans = 0;

    // Smallest Prime Factor (SPF) array for optimized prime factorization
    int* spf = (int*)malloc((maxValue + 1) * sizeof(int));
    for (int i = 0; i <= maxValue; i++) spf[i] = i;

    // Sieve to precompute SPF for all numbers up to maxValue
    for (int i = 2; i * i <= maxValue; i++) {
        if (spf[i] == i) { // i is prime
            for (int j = i * i; j <= maxValue; j += i) {
                if (spf[j] == j) { // only update if j's spf is not yet found
                    spf[j] = i;
                }
            }
        }
    }

    // Iterate through each possible last element 'v' of an ideal array
    for (int v = 1; v <= maxValue; v++) {
        long long current_v_ways = 1;
        int temp_v = v;

        // Prime factorize 'v' using SPF
        while (temp_v > 1) {
            int p = spf[temp_v]; // Smallest prime factor of temp_v
            int count_e = 0;     // Exponent of prime p in v
            while (temp_v % p == 0) {
                count_e++;
                temp_v /= p;
            }
            // For each prime factor p with exponent count_e, the number of ways to distribute
            // these 'count_e' factors among 'n' positions (x_1, ..., x_n) is given by
            // stars and bars formula: C(count_e + n - 1, n - 1).
            current_v_ways = (current_v_ways * nCr_mod_p(count_e + n - 1, n - 1)) % MOD;
        }
        total_ans = (total_ans + current_v_ways) % MOD;
    }

    // Free dynamically allocated memory
    free(fact);
    free(invFact);
    free(spf);

    return (int)total_ans;
}