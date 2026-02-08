#include <stdlib.h> // For malloc, free
#include <limits.h> // For LLONG_MIN

long long max(long long a, long long b) {
    return a > b ? a : b;
}

int maximumScore(int* nums, int numsSize, int* multipliers, int multipliersSize) {
    int n = numsSize;
    int m = multipliersSize;

    // dp[j] stores the maximum score after 'i' operations, having taken 'j' elements from the left.
    // The size of dp array is m + 1 because 'j' (elements from left) can range from 0 to 'i',
    // and 'i' can go up to 'm'.
    long long* dp = (long long*)malloc((m + 1) * sizeof(long long));
    if (dp == NULL) {
        // Handle allocation error if necessary, though LeetCode environment usually guarantees success
        return 0; 
    }

    // Initialize dp array.
    // dp[0] is the base case: 0 score after 0 operations, taking 0 elements from left.
    dp[0] = 0;
    // All other dp[j] for j > 0 are initialized to a very small number,
    // indicating they are unreachable or haven't been calculated yet for the current number of operations.
    for (int j = 1; j <= m; ++j) {
        dp[j] = LLONG_MIN;
    }

    // Iterate through each multiplier (operation)
    // 'i' represents the current number of operations performed (from 1 to m)
    for (int i = 1; i <= m; ++i) {
        long long current_multiplier = multipliers[i - 1]; // multipliers are 0-indexed

        // Iterate 'j' (number of elements taken from left) from 'i' down to 0.
        // We iterate backwards to ensure that dp[j-1] and dp[j] used in the calculation
        // are from the *previous* iteration (i-1 operations).
        for (int j = i; j >= 0; --j) {
            long long take_left_score = LLONG_MIN;
            long long take_right_score = LLONG_MIN;

            // Option 1: Take the j-th element from the left side of nums.
            // This means (j-1) elements were taken from left in the previous (i-1) operations.
            // Requires j > 0 and dp[j-1] must be a valid score from previous operations.
            if (j > 0 && dp[j - 1] != LLONG_MIN) {
                take_left_score = dp[j - 1] + current_multiplier * nums[j - 1];
            }

            // Option 2: Take an element from the right side of nums.
            // If 'j' elements are taken from left, and 'i' operations are done in total,
            // then 'i - j' elements must have been taken from the right.
            // The index of the element taken from the right is nums[n - (i - j)].
            // This means 'j' elements were taken from left in the previous (i-1) operations.
            // Requires dp[j] must be a valid score from previous operations.
            // The index `n - (i - j)` will always be valid because `i <= m <= n` and `j >= 0`.
            if (dp[j] != LLONG_MIN) {
                take_right_score = dp[j] + current_multiplier * nums[n - (i - j)];
            }

            dp[j] = max(take_left_score, take_right_score);
        }
    }

    // After 'm' operations, find the maximum score among all possible 'j' (elements taken from left).
    long long max_score = LLONG_MIN;
    for (int j = 0; j <= m; ++j) {
        max_score = max(max_score, dp[j]);
    }

    free(dp); // Free the allocated memory
    return (int)max_score; // Cast to int as per problem return type
}