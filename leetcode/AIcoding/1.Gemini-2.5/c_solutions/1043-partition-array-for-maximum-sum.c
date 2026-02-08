#include <stdlib.h> // For malloc, free

int max(int a, int b) {
    return a > b ? a : b;
}

int maxSumAfterPartitioning(int* arr, int arrSize, int k) {
    // dp[i] will store the maximum sum for the subarray arr[0...i-1]
    int* dp = (int*)malloc((arrSize + 1) * sizeof(int));
    if (dp == NULL) {
        // Handle allocation error, though LeetCode usually guarantees success
        return 0; 
    }

    // Base case: an empty prefix has a sum of 0
    dp[0] = 0;

    // Iterate through each possible end position of the subarray
    for (int i = 1; i <= arrSize; ++i) {
        dp[i] = 0; // Initialize dp[i] for current calculation
        int current_max_val = 0; // To track the maximum value in the current partition

        // Iterate through possible lengths (j) of the last partition
        // The last partition ends at arr[i-1] and has length j
        for (int j = 1; j <= k; ++j) {
            // Check if the partition of length j is valid (i.e., it doesn't go before the start of the array)
            if (i - j < 0) {
                break;
            }

            // arr[i-j] is the leftmost element of the current partition of length j
            // Update current_max_val for the window arr[i-j ... i-1]
            current_max_val = max(current_max_val, arr[i - j]);

            // Calculate the sum if this partition is chosen:
            // dp[i-j] (sum of the prefix before this partition)
            // + current_max_val * j (sum of this partition where all elements become current_max_val)
            dp[i] = max(dp[i], dp[i - j] + current_max_val * j);
        }
    }

    int result = dp[arrSize];
    free(dp); // Free the dynamically allocated memory
    return result;
}