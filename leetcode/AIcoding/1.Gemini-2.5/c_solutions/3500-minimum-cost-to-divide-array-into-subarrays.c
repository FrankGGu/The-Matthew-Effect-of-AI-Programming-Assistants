#include <stdlib.h> // For malloc and free
#include <string.h> // For memset
#include <limits.h> // For LLONG_MAX

#ifndef MIN
#define MIN(a, b) ((a) < (b) ? (a) : (b))
#endif

long long minCost(int* nums, int numsSize, int k) {
    // dp[i] will store the minimum cost to divide the prefix nums[0...i-1]
    // The array size is numsSize + 1 because dp[0] is for an empty prefix.
    long long* dp = (long long*)malloc((numsSize + 1) * sizeof(long long));
    if (dp == NULL) {
        // Handle memory allocation failure (though LeetCode usually guarantees success)
        return -1; 
    }

    // Base case: The cost to divide an empty prefix is 0.
    dp[0] = 0;

    // freq array to count occurrences of numbers within a subarray.
    // nums[i] values are between 0 and 1000 inclusive, so size 1001 is sufficient.
    int freq[1001]; 

    // Iterate through each possible end point 'i' for the prefix nums[0...i-1]
    for (int i = 1; i <= numsSize; ++i) {
        // Initialize dp[i] to a very large value, representing infinity
        dp[i] = LLONG_MAX;

        // For each 'i', we consider all possible starting points 'j' for the last subarray.
        // The last subarray is nums[j...i-1].
        // We iterate 'j' backwards from 'i-1' down to '0' to efficiently calculate trim_val.

        // Reset frequency counts and trim_val for the current outer loop iteration (for dp[i])
        // This is crucial because we are calculating trim_val for *different* subarrays
        // starting from different 'j' but ending at 'i-1'.
        memset(freq, 0, sizeof(freq));
        int trim_val = 0;

        for (int j = i - 1; j >= 0; --j) {
            int val = nums[j];

            // Update trim_val based on the current element nums[j] being added to the subarray nums[j+1...i-1]
            freq[val]++;
            if (freq[val] == 2) {
                // If freq[val] becomes 2, it means 'val' just became a duplicate.
                // It's a new unique element that appears at least twice, so increment trim_val.
                trim_val++;
            }
            // If freq[val] > 2, 'val' already appeared twice or more. Adding another instance
            // does not change the count of *unique* elements appearing at least twice,
            // so trim_val does not change.

            // Calculate the cost of the current subarray nums[j...i-1]
            long long current_subarray_cost = (long long)k + trim_val;

            // If dp[j] is reachable (not LLONG_MAX), update dp[i]
            if (dp[j] != LLONG_MAX) {
                dp[i] = MIN(dp[i], dp[j] + current_subarray_cost);
            }
        }
    }

    // The minimum cost to divide the entire array nums[0...numsSize-1] is dp[numsSize].
    long long result = dp[numsSize];
    free(dp); // Free allocated memory
    return result;
}