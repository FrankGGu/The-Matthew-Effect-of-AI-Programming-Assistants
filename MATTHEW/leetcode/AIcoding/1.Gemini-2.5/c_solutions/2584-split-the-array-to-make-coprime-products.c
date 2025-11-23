#include <stdbool.h>
#include <string.h> // For memset, if needed, but manual loops are fine for small arrays

#define MAX_NUM_VAL 1000
#define MAX_PRIME_COUNT 168 // Number of primes up to 1000

int primes[MAX_PRIME_COUNT];
int num_primes = 0;
int smallest_prime_factor[MAX_NUM_VAL + 1];
int unique_factors_arr[MAX_NUM_VAL + 1][5]; // Max 4 unique prime factors for numbers <= 1000, 5 for safety
int unique_factors_count[MAX_NUM_VAL + 1];

void precompute() {
    // Initialize smallest_prime_factor array
    for (int i = 0; i <= MAX_NUM_VAL; ++i) {
        smallest_prime_factor[i] = i;
        unique_factors_count[i] = 0;
    }

    // Sieve to find smallest prime factor for each number
    for (int i = 2; i <= MAX_NUM_VAL; ++i) {
        if (smallest_prime_factor[i] == i) { // i is prime
            primes[num_primes++] = i;
            // Mark multiples of i
            // Start from i*i because smaller multiples would have been marked by smaller primes
            for (long long j = (long long)i * i; j <= MAX_NUM_VAL; j += i) {
                if (smallest_prime_factor[j] == j) { // Only update if not already marked by a smaller prime
                    smallest_prime_factor[j] = i;
                }
            }
        }
    }

    // Populate unique_factors_arr for each number
    for (int i = 2; i <= MAX_NUM_VAL; ++i) {
        int temp = i;
        while (temp > 1) {
            int p = smallest_prime_factor[temp];
            unique_factors_arr[i][unique_factors_count[i]++] = p;
            while (temp % p == 0) { // Remove all occurrences of this prime factor
                temp /= p;
            }
        }
    }
}

int splitArray(int* nums, int numsSize) {
    // Ensure precompute is called only once across multiple test cases
    static bool precomputed = false;
    if (!precomputed) {
        precompute();
        precomputed = true;
    }

    // left_prime_counts[p] stores how many numbers in the current prefix are divisible by prime p
    int left_prime_counts[MAX_NUM_VAL + 1];
    // right_prime_counts[p] stores how many numbers in the current suffix are divisible by prime p
    int right_prime_counts[MAX_NUM_VAL + 1];

    // Initialize counts to zero
    for (int i = 0; i <= MAX_NUM_VAL; ++i) {
        left_prime_counts[i] = 0;
        right_prime_counts[i] = 0;
    }

    // Initially, all numbers are in the right subarray
    for (int i = 0; i < numsSize; ++i) {
        int num = nums[i];
        for (int j = 0; j < unique_factors_count[num]; ++j) {
            right_prime_counts[unique_factors_arr[num][j]]++;
        }
    }

    int ans = 0;
    // Iterate through possible split points i (0 to numsSize - 2)
    // The split is after nums[i], so nums[0...i] and nums[i+1...numsSize-1]
    for (int i = 0; i < numsSize - 1; ++i) {
        int num_to_move = nums[i];

        // Move nums[i] from the right subarray to the left subarray
        for (int j = 0; j < unique_factors_count[num_to_move]; ++j) {
            int p = unique_factors_arr[num_to_move][j];
            left_prime_counts[p]++;
            right_prime_counts[p]--;
        }

        // Check for coprimality: P1 and P2 are coprime if they share no common prime factors.
        // This means for every prime p, it's not possible that (p divides P1 AND p divides P2).
        // p divides P1 if left_prime_counts[p] > 0.
        // p divides P2 if right_prime_counts[p] > 0.
        bool is_coprime = true;
        for (int j = 0; j < num_primes; ++j) {
            int p = primes[j];
            if (left_prime_counts[p] > 0 && right_prime_counts[p] > 0) {
                is_coprime = false;
                break;
            }
        }

        if (is_coprime) {
            ans++;
        }
    }

    return ans;
}