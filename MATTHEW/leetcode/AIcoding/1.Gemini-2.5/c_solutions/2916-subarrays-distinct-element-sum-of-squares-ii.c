#include <stdlib.h> // For malloc, free

int sumOfSquares(int* nums, int numsSize) {
    long long MOD = 1e9 + 7;
    long long total_sum = 0;

    int max_val = 0;
    for (int i = 0; i < numsSize; ++i) {
        if (nums[i] > max_val) {
            max_val = nums[i];
        }
    }

    // last_occurrence[value] stores the index of the last occurrence of 'value'.
    // Initialize with -1 to indicate no prior occurrence.
    int* last_occurrence = (int*)malloc((max_val + 1) * sizeof(int));
    if (last_occurrence == NULL) {
        // Handle allocation error, though LeetCode usually guarantees success
        return -1; 
    }
    for (int i = 0; i <= max_val; ++i) {
        last_occurrence[i] = -1;
    }

    for (int k = 0; k < numsSize; ++k) {
        int current_num = nums[k];
        int prev_k = last_occurrence[current_num];

        // term1: Number of valid left endpoints 'j' for which nums[k] is the first occurrence of its value
        // These are j such that prev_k < j <= k. The count is k - prev_k.
        long long term1 = (long long)(k - prev_k); 

        // term2: Number of valid right endpoints 'i' for which nums[k] is part of the subarray
        // These are i such that k <= i < numsSize. The count is numsSize - k.
        long long term2 = (long long)(numsSize - k); 

        // num_sq: The square of the current number, modulo MOD
        long long num_sq = (long long)current_num * current_num % MOD;

        // Calculate the contribution of nums[k]^2 to the total sum
        // This is (k - prev_k) * (numsSize - k) * nums[k]^2, all modulo MOD
        long long contribution = (term1 * term2) % MOD;
        contribution = (contribution * num_sq) % MOD;

        total_sum = (total_sum + contribution) % MOD;

        // Update the last occurrence of current_num to the current index k
        last_occurrence[current_num] = k; 
    }

    free(last_occurrence); // Free dynamically allocated memory

    return (int)total_sum;
}