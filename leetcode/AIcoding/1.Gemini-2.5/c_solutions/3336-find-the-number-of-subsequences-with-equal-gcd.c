#include <stdlib.h> // For calloc, free

#define MOD 1000000007
#define MAX_ARRAY_VAL 200000 // Maximum possible value for nums[i] or k

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

int findGoodSubsequences(int* nums, int numsSize, int k) {
    // max_val_prime will store the maximum value of (num / k) encountered
    // for numbers in nums that are multiples of k.
    int max_val_prime = 0;

    // freq array stores the frequency of each (num / k) value.
    // The maximum possible value for num / k is MAX_ARRAY_VAL / 1 = 200000.
    // So, we need an array of size MAX_ARRAY_VAL + 1.
    int* freq = (int*)calloc(MAX_ARRAY_VAL + 1, sizeof(int));
    if (!freq) {
        return -1; // Allocation failed
    }

    // Populate freq array and find max_val_prime
    for (int i = 0; i < numsSize; i++) {
        if (nums[i] % k == 0) {
            int val_prime = nums[i] / k;
            freq[val_prime]++;
            if (val_prime > max_val_prime) {
                max_val_prime = val_prime;
            }
        }
    }

    // If no numbers are multiples of k, then no subsequences can have GCD k.
    if (max_val_prime == 0) {
        free(freq);
        return 0;
    }

    // num_multiples[g] stores the count of elements in the 'transformed' array
    // (nums[i] / k for nums[i] % k == 0) that are multiples of g.
    int* num_multiples = (int*)calloc(max_val_prime + 1, sizeof(int));
    if (!num_multiples) {
        free(freq);
        return -1; // Allocation failed
    }

    // Calculate num_multiples[g] for each g from 1 to max_val_prime
    // This is done by summing frequencies of multiples of g.
    for (int g = 1; g <= max_val_prime; g++) {
        for (int m = g; m <= max_val_prime; m += g) {
            num_multiples[g] += freq[m];
        }
    }

    // ans[g] will store the number of non-empty subsequences whose GCD is exactly g.
    int* ans = (int*)calloc(max_val_prime + 1, sizeof(int));
    if (!ans) {
        free(freq);
        free(num_multiples);
        return -1; // Allocation failed
    }

    // Iterate g from max_val_prime down to 1 to apply inclusion-exclusion principle.
    // For each g, calculate subsequences whose elements are all multiples of g,
    // then subtract those whose GCD is a higher multiple of g (2g, 3g, etc.).
    for (int g = max_val_prime; g >= 1; g--) {
        long long current_count = num_multiples[g];

        if (current_count == 0) {
            ans[g] = 0;
        } else {
            // Total non-empty subsequences formed from elements that are multiples of g.
            // Their GCD will be a multiple of g.
            ans[g] = (int)((power(2, current_count) - 1 + MOD) % MOD);

            // Subtract subsequences whose GCD is a multiple of g but not exactly g.
            // These are subsequences whose GCD is 2g, 3g, 4g, ...
            for (int m = 2 * g; m <= max_val_prime; m += g) {
                ans[g] = (ans[g] - ans[m] + MOD) % MOD;
            }
        }
    }

    // The final answer is the number of subsequences with GCD exactly 1.
    int result = ans[1];

    // Free dynamically allocated memory
    free(freq);
    free(num_multiples);
    free(ans);

    return result;
}