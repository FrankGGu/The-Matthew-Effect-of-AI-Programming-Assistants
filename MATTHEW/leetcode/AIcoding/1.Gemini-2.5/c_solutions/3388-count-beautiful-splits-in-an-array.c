#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <math.h> // Required for sqrt (though d*d is used to avoid it)

#define MAX_N 1000
#define MAX_DISTINCT_PRIME_FACTORS 10

static int get_factor_count(int num, int prime) {
    int count = 0;
    // num > 0 check is for robustness, prime should always be > 1
    while (num > 0 && num % prime == 0) {
        count++;
        num /= prime;
    }
    return count;
}

int countBeautifulSplits(int* nums, int numsSize, int k) {
    if (numsSize < 2) {
        return 0; // A split requires at least two non-empty subarrays
    }

    // Special case: if k is 1, any non-empty product is divisible by 1.
    // Thus, any valid split (numsSize - 1 splits) is beautiful.
    if (k == 1) {
        return numsSize - 1;
    }

    // Step 1: Get prime factors of k and their required counts
    int primes[MAX_DISTINCT_PRIME_FACTORS];
    int k_counts[MAX_DISTINCT_PRIME_FACTORS];
    int num_distinct_primes = 0;

    int temp_k = k;
    for (int d = 2; d * d <= temp_k; ++d) {
        if (temp_k % d == 0) {
            primes[num_distinct_primes] = d;
            int count = 0;
            while (temp_k % d == 0) {
                count++;
                temp_k /= d;
            }
            k_counts[num_distinct_primes] = count;
            num_distinct_primes++;
        }
    }
    if (temp_k > 1) { // If temp_k still has a value > 1, it's a prime factor itself
        primes[num_distinct_primes] = temp_k;
        k_counts[num_distinct_primes] = 1;
        num_distinct_primes++;
    }

    // Step 2: Calculate prefix factor counts
    // prefix_factor_counts[i][j] stores the total count of primes[j] in the product nums[0] * ... * nums[i-1]
    // The size is numsSize + 1 to handle prefix up to index numsSize-1 (i.e., prefix_factor_counts[numsSize])
    int prefix_factor_counts[MAX_N + 1][MAX_DISTINCT_PRIME_FACTORS] = {0};

    for (int i = 0; i < numsSize; ++i) {
        for (int j = 0; j < num_distinct_primes; ++j) {
            prefix_factor_counts[i + 1][j] = prefix_factor_counts[i][j] + get_factor_count(nums[i], primes[j]);
        }
    }

    // Step 3: Calculate suffix factor counts
    // suffix_factor_counts[i][j] stores the total count of primes[j] in the product nums[i] * ... * nums[numsSize-1]
    // The size is numsSize + 1 to handle suffix starting from index 0 (i.e., suffix_factor_counts[0])
    int suffix_factor_counts[MAX_N + 1][MAX_DISTINCT_PRIME_FACTORS] = {0};

    for (int i = numsSize - 1; i >= 0; --i) {
        for (int j = 0; j < num_distinct_primes; ++j) {
            suffix_factor_counts[i][j] = suffix_factor_counts[i + 1][j] + get_factor_count(nums[i], primes[j]);
        }
    }

    // Step 4: Iterate through all possible split points and count beautiful splits
    int beautiful_splits_count = 0;
    // A split point 'i' means the array is split into nums[0...i-1] (left) and nums[i...numsSize-1] (right).
    // 'i' can range from 1 to numsSize - 1 (inclusive) to ensure both parts are non-empty.
    for (int i = 1; i < numsSize; ++i) {
        bool left_divisible = true;
        for (int j = 0; j < num_distinct_primes; ++j) {
            if (prefix_factor_counts[i][j] < k_counts[j]) {
                left_divisible = false;
                break;
            }
        }

        if (!left_divisible) {
            continue; // Left part is not divisible by k, so this split is not beautiful
        }

        bool right_divisible = true;
        for (int j = 0; j < num_distinct_primes; ++j) {
            if (suffix_factor_counts[i][j] < k_counts[j]) {
                right_divisible = false;
                break;
            }
        }

        if (right_divisible) {
            beautiful_splits_count++; // Both parts are divisible by k
        }
    }

    return beautiful_splits_count;
}