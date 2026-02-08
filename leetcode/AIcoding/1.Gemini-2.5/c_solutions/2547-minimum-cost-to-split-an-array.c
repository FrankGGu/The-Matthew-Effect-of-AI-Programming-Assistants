#include <stdlib.h> // For malloc, free
#include <limits.h> // For INT_MAX
#include <string.h> // For memset

int min(int a, int b) {
    return a < b ? a : b;
}

int minCostToSplitArray(int* nums, int numsSize, int k) {
    int n = numsSize;

    // dp[i] will store the minimum cost to split the prefix nums[0...i-1]
    // The size is n+1 because dp[0] is for an empty prefix.
    int* dp = (int*)malloc((n + 1) * sizeof(int));

    // Handle potential memory allocation failure
    if (dp == NULL) {
        return -1; // Or appropriate error handling
    }

    // Base case: cost to split an empty array is 0
    dp[0] = 0;

    // freq array to count occurrences of numbers in a subarray.
    // Since 0 <= nums[i] < nums.length, values are within [0, n-1].
    // A size of n is sufficient.
    int* freq = (int*)malloc(n * sizeof(int));
    if (freq == NULL) {
        free(dp);
        return -1; // Or appropriate error handling
    }

    // Iterate through each possible ending position `i` for the current prefix `nums[0...i-1]`
    for (int i = 1; i <= n; ++i) {
        dp[i] = INT_MAX; // Initialize dp[i] to a very large value

        // Reset frequency map and trim_count for each new `i`
        // as we will be calculating trim for subarrays ending at `i-1`.
        memset(freq, 0, n * sizeof(int));
        int trim_count = 0;

        // Iterate `j` from `i-1` down to `0` to consider all possible starting positions
        // for the last subarray `nums[j...i-1]`.
        for (int j = i - 1; j >= 0; --j) {
            int val = nums[j];

            // Update trim_count: it increments if an element's frequency
            // goes from 1 to 2 (meaning it becomes a duplicate).
            if (freq[val] == 1) {
                trim_count++;
            }
            freq[val]++; // Increment frequency of the current element

            // Calculate the cost contribution of the current subarray `nums[j...i-1]`
            // This is k (problem's given integer) + trim_count.
            int cost_of_current_subarray = k + trim_count;

            // DP transition:
            // If dp[j] is INT_MAX, it means the prefix nums[0...j-1] is unreachable,
            // so we cannot form a valid split ending here.
            if (dp[j] != INT_MAX) {
                // If j == 0, it means nums[0...i-1] is the first (and only) subarray so far.
                // The total cost is just its cost_of_current_subarray (k-1 term is 0 for 1 subarray).
                // Our DP state handles the k-1 term implicitly:
                // If s subarrays, total cost = sum(K + trim(Am)) + s - 1
                // This can be rewritten as:
                // sum(K + trim(Am) + 1) - 1
                // So, each subarray effectively adds (K + trim(Am) + 1) to the sum,
                // and we subtract 1 at the very end.
                // When j == 0, it's the first subarray, so no previous dp[j] to add to.
                // The cost is just `cost_of_current_subarray`.
                // This corresponds to `dp[0] + cost_of_current_subarray` if dp[0] was -1.
                // But with dp[0]=0, and the +1 term, we need to be careful.
                // The current DP formulation is:
                // dp[i] = min cost for nums[0...i-1]
                // dp[i] = min(dp[j] + cost_of_current_subarray + 1) for j > 0
                // dp[i] = min(cost_of_current_subarray) for j == 0
                // This correctly accounts for the `s-1` term.
                // For s=1, dp[i] = cost_of_current_subarray. (s-1 = 0)
                // For s>1, dp[i] = dp[j] + cost_of_current_subarray + 1.
                // If dp[j] is for s_j subarrays, it already includes s_j-1.
                // Adding a new subarray makes it s_j+1 subarrays.
                // New total cost: (dp[j] - (s_j-1)) + cost_of_current_subarray + ((s_j+1)-1)
                // = dp[j] - s_j + 1 + cost_of_current_subarray + s_j
                // = dp[j] + cost_of_current_subarray + 1. This is correct.

                if (j == 0) {
                    dp[i] = min(dp[i], cost_of_current_subarray);
                } else {
                    dp[i] = min(dp[i], dp[j] + cost_of_current_subarray + 1);
                }
            }
        }
    }

    int result = dp[n]; // The final answer is the minimum cost for the entire array

    // Free allocated memory
    free(dp);
    free(freq);

    return result;
}