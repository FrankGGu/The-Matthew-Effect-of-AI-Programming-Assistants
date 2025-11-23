#include <stdlib.h> // Required for malloc and free

long long countInterestingSubarrays(int* nums, int numsSize, int modulo, int k) {
    long long count = 0;
    int current_sum_mod = 0;

    // freq array to store counts of prefix sums modulo 'modulo'.
    // The size of `modulo` can be up to 10^5, so an array is feasible.
    // Using calloc to initialize all elements to 0.
    int* freq = (int*)calloc(modulo, sizeof(int));
    if (freq == NULL) {
        // Handle allocation failure if necessary, though LeetCode usually guarantees success.
        // For competitive programming, this might be a rare edge case.
        return -1; // Or some other error indicator
    }

    // Initialize freq[0] to 1 to account for the "empty" prefix sum (sum 0),
    // which allows subarrays starting from index 0 to be counted correctly.
    freq[0] = 1;

    for (int i = 0; i < numsSize; i++) {
        int val_to_add = 0;
        if (nums[i] % modulo == k) {
            val_to_add = 1;
        }

        // Update the current running sum modulo 'modulo'.
        // Since val_to_add is 0 or 1, and current_sum_mod is always non-negative,
        // the result of % modulo will always be in [0, modulo-1].
        current_sum_mod = (current_sum_mod + val_to_add) % modulo;

        // Add the count of previous prefix sums that have the same remainder
        // as the current prefix sum. Each such previous prefix sum 'p_i'
        // forms an "interesting" subarray with the current prefix sum 'p_j'
        // because (p_j - p_i) % modulo == 0.
        count += freq[current_sum_mod];

        // Increment the frequency of the current prefix sum modulo 'modulo'.
        freq[current_sum_mod]++;
    }

    // Free the dynamically allocated memory.
    free(freq);

    return count;
}