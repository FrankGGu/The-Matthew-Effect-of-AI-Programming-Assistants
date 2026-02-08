import "math"

func maxSumOfKSubarrays(nums []int, k int, m int) int {
    n := len(nums)

    // prefixSum[i] stores the sum of nums[0...i-1]
    // prefixSum[0] = 0
    // prefixSum[i] = nums[0] + ... + nums[i-1]
    prefixSum := make([]int, n+1)
    for i := 0; i < n; i++ {
        prefixSum[i+1] = prefixSum[i] + nums[i]
    }

    // dp_prev[i] stores the maximum sum of (j-1) non-overlapping subarrays
    // using elements up to index i-1.
    // dp_curr[i] stores the maximum sum of j non-overlapping subarrays
    // using elements up to index i-1.
    dp_prev := make([]int, n+1) // Corresponds to dp[j-1][...]
    dp_curr := make([]int, n+1) // Corresponds to dp[j][...]

    // Initialize dp_prev for j=0 (base case: 0 subarrays have sum 0).
    // All elements in dp_prev are 0 by default for int slice.

    for j := 1; j <= k; j++ {
        // Initialize dp_curr for the current j.
        // All states are impossible initially, except if k=0 (handled by dp_prev default).
        for i := 0; i <= n; i++ {
            dp_curr[i] = math.MinInt64
        }

        // max_val_prev_part tracks max(dp_prev[x] - prefixSum[x]) for valid x.
        // x represents the index *after* the (j-1)-th subarray.
        max_val_prev_part := math.MinInt64

        // Iterate through all possible ending positions for the j-th subarray.
        for i := 1; i <= n; i++ {
            // Option 1: nums[i-1] is not part of the j-th subarray.
            // The maximum sum is the same as using elements up to index i-2.
            dp_curr[i] = dp_curr[i-1]

            // If we have enough elements to potentially form (j-1) subarrays ending before index (i-m),
            // we can update max_val_prev_part.
            // The (j-1)-th subarray would end at or before index (i-m-1).
            // So, its "end + 1" index (x in dp_prev[x]) would be i-m.
            // Condition: i-m must be a valid index for dp_prev, and there must be enough elements
            // for (j-1) subarrays of length m, i.e., i-m >= (j-1)*m.
            if i-m >= (j-1)*m {
                if dp_prev[i-m] != math.MinInt64 {
                    // Update max_val_prev_part with a new candidate:
                    // dp_prev[i-m] is the max sum of (j-1) subarrays using nums[0...i-m-1].
                    // We subtract prefixSum[i-m] because we will add prefixSum[i] later
                    // to get the sum of the current (j-th) subarray (nums[p...i-1]).
                    max_val_prev_part = max(max_val_prev_part, dp_prev[i-m] - prefixSum[i-m])
                }
            }

            // Option 2: nums[i-1] is the end of the j-th subarray.
            // This subarray must have length at least m.
            // It starts at index p, where p <= i-m.
            // Its sum is prefixSum[i] - prefixSum[p].
            // The previous (j-1) subarrays must end before p. Their max sum is dp_prev[p].
            // We want to maximize (dp_prev[p] + prefixSum[i] - prefixSum[p]),
            // which is prefixSum[i] + (dp_prev[p] - prefixSum[p]).
            // The (dp_prev[p] - prefixSum[p]) part is what max_val_prev_part tracks.
            // This option is only possible if we have enough elements for j subarrays,
            // i.e., i >= j*m.
            if i >= j*m {
                if max_val_prev_part != math.MinInt64 {
                    dp_curr[i] = max(dp_curr[i], prefixSum[i] + max_val_prev_part)
                }
            }
        }
        // After processing all i for the current j, dp_curr becomes dp_prev for the next j.
        copy(dp_prev, dp_curr)
    }

    // The final answer is dp_curr[n] (max sum of K subarrays using elements up to n-1).
    // If it's still math.MinInt64, it means K subarrays could not be formed.
    return dp_curr[n]
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}