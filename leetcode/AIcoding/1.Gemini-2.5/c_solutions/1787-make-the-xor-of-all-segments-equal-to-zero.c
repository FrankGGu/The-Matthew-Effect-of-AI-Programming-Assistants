#include <stdlib.h>
#include <string.h>
#include <limits.h>

#define MAX_XOR_VAL 1024 // Since nums[i] < 2^10 (i.e., nums[i] <= 1023), max XOR sum is 2^10 - 1

int minOperations(int* nums, int numsSize, int k) {
    // col_freq[j][val] stores the frequency of 'val' in column 'j'.
    // A column 'j' consists of elements nums[j], nums[j+k], nums[j+2k], ...
    int** col_freq = (int**)malloc(k * sizeof(int*));
    for (int i = 0; i < k; i++) {
        col_freq[i] = (int*)calloc(MAX_XOR_VAL, sizeof(int));
    }

    // col_sizes[j] stores the total number of elements in column 'j'.
    // This is not strictly needed for the DP logic, but useful for understanding.
    // int* col_sizes = (int*)calloc(k, sizeof(int)); 

    // Precompute frequencies for each column
    for (int i = 0; i < numsSize; i++) {
        col_freq[i % k][nums[i]]++;
        // col_sizes[i % k]++;
    }

    // dp[xor_val] stores the maximum number of elements we can keep unchanged
    // from previous columns (0 to j-1) such that their chosen values XOR to xor_val.
    int* dp = (int*)malloc(MAX_XOR_VAL * sizeof(int));
    int* new_dp = (int*)malloc(MAX_XOR_VAL * sizeof(int));

    // Initialize dp table
    for (int i = 0; i < MAX_XOR_VAL; i++) {
        dp[i] = INT_MIN; // Use INT_MIN to represent unreachable states
    }
    dp[0] = 0; // Base case: 0 elements kept, XOR sum 0, before processing any column

    // Iterate through each column from 0 to k-1
    for (int j = 0; j < k; j++) {
        // Find the maximum number of elements kept from previous columns (0 to j-1).
        // This value is used for the case where we change all elements in the current column 'j'.
        // In this case, we keep 0 elements from column 'j', so the total kept elements
        // would just be this 'max_prev_dp_val'.
        int max_prev_dp_val = INT_MIN;
        for (int xor_val = 0; xor_val < MAX_XOR_VAL; xor_val++) {
            if (dp[xor_val] != INT_MIN) {
                if (dp[xor_val] > max_prev_dp_val) {
                    max_prev_dp_val = dp[xor_val];
                }
            }
        }

        // Initialize new_dp for the current column 'j'.
        // Each state in new_dp is initially set to max_prev_dp_val.
        // This covers the scenario where we choose a value for x_j that is not present
        // in column 'j', or we choose to change all elements in column 'j' to some value.
        // In this case, 0 elements from column 'j' are kept unchanged.
        for (int xor_val = 0; xor_val < MAX_XOR_VAL; xor_val++) {
            new_dp[xor_val] = max_prev_dp_val;
        }

        // Iterate through all possible values (0 to 1023) for elements in column 'j'.
        for (int val = 0; val < MAX_XOR_VAL; val++) {
            // Only consider 'val' if it is actually present in column 'j' at least once.
            if (col_freq[j][val] > 0) {
                int count_val = col_freq[j][val];
                // Iterate through all possible previous XOR sums from dp[j]
                for (int prev_xor = 0; prev_xor < MAX_XOR_VAL; prev_xor++) {
                    if (dp[prev_xor] != INT_MIN) { // If prev_xor state was reachable
                        int current_xor = prev_xor ^ val;
                        // Update new_dp[current_xor] by considering keeping 'count_val' elements
                        // from the current column 'j' (by choosing x_j = val).
                        if (dp[prev_xor] + count_val > new_dp[current_xor]) {
                            new_dp[current_xor] = dp[prev_xor] + count_val;
                        }
                    }
                }
            }
        }
        // Copy new_dp to dp for the next iteration (processing column j+1)
        memcpy(dp, new_dp, MAX_XOR_VAL * sizeof(int));
    }

    // The minimum operations is the total number of elements 'numsSize'
    // minus the maximum number of elements we can keep unchanged
    // such that the final XOR sum of chosen values (x_0 ^ ... ^ x_{k-1}) is 0.
    int result = numsSize - dp[0];

    // Free allocated memory
    for (int i = 0; i < k; i++) {
        free(col_freq[i]);
    }
    free(col_freq);
    // free(col_sizes); // Not strictly needed, so not freed if not allocated.
    free(dp);
    free(new_dp);

    return result;
}