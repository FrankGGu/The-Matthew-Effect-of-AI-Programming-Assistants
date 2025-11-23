#include <stdbool.h>
#include <stdlib.h>
#include <string.h>

#define MAX_VAL 1000
#define MAX_PRIMES_COUNT 168 // Number of primes <= 1000

static int primes[MAX_PRIMES_COUNT];
static int num_primes_found = 0;
static bool is_prime[MAX_VAL + 1];
static bool precomputation_done = false;

static int prime_exponents_cache[MAX_VAL + 1][MAX_PRIMES_COUNT];

void sieve_and_factorize() {
    if (precomputation_done) return;

    memset(is_prime, true, sizeof(is_prime));
    is_prime[0] = is_prime[1] = false;
    for (int p = 2; p * p <= MAX_VAL; p++) {
        if (is_prime[p]) {
            for (int i = p * p; i <= MAX_VAL; i += p)
                is_prime[i] = false;
        }
    }

    num_primes_found = 0;
    for (int p = 2; p <= MAX_VAL; p++) {
        if (is_prime[p]) {
            primes[num_primes_found++] = p;
        }
    }

    for (int val = 1; val <= MAX_VAL; val++) {
        int temp_val = val;
        for (int p_idx = 0; p_idx < num_primes_found; p_idx++) {
            int p = primes[p_idx];
            int count = 0;
            while (temp_val > 0 && temp_val % p == 0) {
                count++;
                temp_val /= p;
            }
            prime_exponents_cache[val][p_idx] = count;
        }
    }
    precomputation_done = true;
}

int max(int a, int b) {
    return a > b ? a : b;
}

int maximumSubarrayWithEqualProducts(int* nums, int numsSize) {
    sieve_and_factorize();

    int max_len = 0;
    if (numsSize < 2) {
        return 0;
    }

    int current_left_exp_sums[MAX_PRIMES_COUNT];
    int current_right_exp_sums[MAX_PRIMES_COUNT];

    // Case 1: Even length subarrays (split between k and k+1)
    // The split is `nums[left_idx ... k]` and `nums[k+1 ... right_idx]`
    for (int k = 0; k < numsSize - 1; k++) {
        memset(current_left_exp_sums, 0, sizeof(current_left_exp_sums));
        memset(current_right_exp_sums, 0, sizeof(current_right_exp_sums));

        int left_idx = k;
        int right_idx = k + 1;

        while (left_idx >= 0 && right_idx < numsSize) {
            for (int p_idx = 0; p_idx < num_primes_found; p_idx++) {
                current_left_exp_sums[p_idx] += prime_exponents_cache[nums[left_idx]][p_idx];
                current_right_exp_sums[p_idx] += prime_exponents_cache[nums[right_idx]][p_idx];
            }

            bool products_equal = true;
            for (int p_idx = 0; p_idx < num_primes_found; p_idx++) {
                if (current_left_exp_sums[p_idx] != current_right_exp_sums[p_idx]) {
                    products_equal = false;
                    break;
                }
            }
            if (products_equal) {
                max_len = max(max_len, right_idx - left_idx + 1);
            }

            left_idx--;
            right_idx++;
        }
    }

    // Case 2: Odd length subarrays (split around k)
    // The split is `nums[left_idx ... k-1]` and `nums[k+1 ... right_idx]`
    // The middle element nums[k] is not part of either product.
    for (int k = 0; k < numsSize; k++) {
        memset(current_left_exp_sums, 0, sizeof(current_left_exp_sums));
        memset(current_right_exp_sums, 0, sizeof(current_right_exp_sums));

        int left_idx = k - 1;
        int right_idx = k + 1;

        while (left_idx >= 0 && right_idx < numsSize) {
            for (int p_idx = 0; p_idx < num_primes_found; p_idx++) {
                current_left_exp_sums[p_idx] += prime_exponents_cache[nums[left_idx]][p_idx];
                current_right_exp_sums[p_idx] += prime_exponents_cache[nums[right_idx]][p_idx];
            }

            bool products_equal = true;
            for (int p_idx = 0; p_idx < num_primes_found; p_idx++) {
                if (current_left_exp_sums[p_idx] != current_right_exp_sums[p_idx]) {
                    products_equal = false;
                    break;
                }
            }
            if (products_equal) {
                max_len = max(max_len, right_idx - left_idx + 1);
            }

            left_idx--;
            right_idx++;
        }
    }

    return max_len;
}