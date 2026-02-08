#include <stdlib.h>
#include <stdio.h>
#include <string.h>

int compare(const void *a, const void *b) {
    return (*(int *)a - *(int *)b);
}

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

long long* fact;
long long* invFact;
long long* pow2;
long long MOD = 1000000007;

void precompute_factorials(int n) {
    fact = (long long*)malloc((n + 1) * sizeof(long long));
    invFact = (long long*)malloc((n + 1) * sizeof(long long));
    pow2 = (long long*)malloc((n + 1) * sizeof(long long));

    fact[0] = 1;
    invFact[0] = 1;
    pow2[0] = 1;

    for (int i = 1; i <= n; i++) {
        fact[i] = (fact[i - 1] * i) % MOD;
        pow2[i] = (pow2[i - 1] * 2) % MOD;
    }
    invFact[n] = modInverse(fact[n]);
    for (int i = n - 1; i >= 1; i--) {
        invFact[i] = (invFact[i + 1] * (i + 1)) % MOD;
    }
}

long long maximumAndMinimumSum(int* nums, int numsSize, int k) {
    qsort(nums, numsSize, sizeof(int), compare);

    precompute_factorials(numsSize);

    long long total_sum = 0;
    long long* coeffs = (long long*)calloc(numsSize, sizeof(long long));

    if (k == 0) { 
        // No subsequences of size 0, sum is 0.
        // total_sum remains 0.
    } else { // k >= 1
        // coeffs[X] stores sum_{p=0}^{min(k-1, X)} C(X, p)
        // This is S_k(X) in the thought process.

        coeffs[0] = 1; // For X=0, min(k-1, 0) = 0. C(0,0) = 1.

        // S_prev stores S_k(X-1)
        long long S_prev = 1; 
        // C_prev_X_k_minus_1 stores C(X-1, k-1)
        long long C_prev_X_k_minus_1 = 0; 

        for (int X = 1; X < numsSize; ++X) {
            long long S_curr;
            long long C_curr_X_k_minus_1;

            if (X < k - 1) { // If X < k-1, then min(k-1, X) = X. Sum is 2^X.
                S_curr = pow2[X];
                C_curr_X_k_minus_1 = 0; // C(X, k-1) is 0 if X < k-1
            } else if (X == k - 1) { // If X = k-1, then min(k-1, X) = X. Sum is 2^X.
                S_curr = pow2[X]; 
                C_curr_X_k_minus_1 = 1; // C(k-1, k-1) = 1
            } else { // X > k - 1. Use recurrence S_k(X) = (2 * S_k(X-1) - C(X-1, k-1)) % MOD
                // Calculate C(X, k-1) from C(X-1, k-1)
                // C(X, k-1) = C(X-1, k-1) * X / (X - (k-1))
                C_curr_X_k_minus_1 = (C_prev_X_k_minus_1 * X) % MOD;
                C_curr_X_k_minus_1 = (C_curr_X_k_minus_1 * modInverse(X - (k - 1))) % MOD;

                // S_k(X) = (2 * S_k(X-1) - C(X-1, k-1)) % MOD
                S_curr = (2 * S_prev % MOD - C_prev_X_k_minus_1 + MOD) % MOD;
            }
            coeffs[X] = S_curr;
            S_prev = S_curr;
            C_prev_X_k_minus_1 = C_curr_X_k_minus_1;
        }
    }

    for (int i = 0; i < numsSize; ++i) {
        long long coeff_max_i = coeffs[i]; // Number of subsequences where nums[i] is max
        long long coeff_min_i = coeffs[numsSize - 1 - i]; // Number of subsequences where nums[i] is min

        long long term = (long long)nums[i] * (coeff_max_i + coeff_min_i) % MOD;
        total_sum = (total_sum + term) % MOD;
    }

    free(fact);
    free(invFact);
    free(pow2);
    free(coeffs);

    return total_sum;
}