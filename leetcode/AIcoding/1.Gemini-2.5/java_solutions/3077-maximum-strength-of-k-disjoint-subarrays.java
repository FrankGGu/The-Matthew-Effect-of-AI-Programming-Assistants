import java.util.Arrays;

class Solution {
    private long[] prefixSum;
    private long[][] dp;
    private int N;

    public long maximumStrength(int[] nums, int k) {
        N = nums.length;
        prefixSum = new long[N + 1];
        for (int i = 0; i < N; i++) {
            prefixSum[i + 1] = prefixSum[i] + nums[i];
        }

        dp = new long[k + 1][N + 1];

        // Initialize dp table with a very small value to represent negative infinity.
        // Using Long.MIN_VALUE / 2 to prevent overflow when adding or subtracting.
        for (int i = 0; i <= k; i++) {
            Arrays.fill(dp[i], Long.MIN_VALUE / 2);
        }

        // Base case: 0 subarrays, 0 strength for any prefix length.
        // dp[0][i] represents the maximum strength using 0 subarrays considering nums[0...i-1].
        // This is always 0.
        for (int i = 0; i <= N; i++) {
            dp[0][i] = 0;
        }

        // Iterate for each number of subarrays from 1 to k.
        for (int currentK = 1; currentK <= k; currentK++) {
            // Apply Divide and Conquer Optimization (Knuth's Optimization)
            // to compute dp[currentK][i] for all i from 1 to N.
            // i_low to i_high: range of indices for which we are computing dp[currentK][i].
            // j_low to j_high: range of indices for the optimal j_start for dp[currentK][i].
            // j_start is the prefix length for currentK-1 subarrays, and also the start index of the currentK-th subarray.
            solve(currentK, currentK, N, currentK - 1, N - 1);
        }

        return dp[k][N];
    }

    // This is the recursive function for Divide and Conquer Optimization.
    // k_val: current number of subarrays.
    // i_low, i_high: range of prefix lengths (for currentK-th subarray ending at i-1).
    // j_low, j_high: range of possible starting indices (j_start) for the currentK-th subarray.
    private void solve(int k_val, int i_low, int i_high, int j_low, int j_high) {
        if (i_low > i_high) {
            return;
        }

        int mid = i_low + (i_high - i_low) / 2; // Current prefix length 'i' for which we compute dp[k_val][mid]
        int best_j_start = -1;
        long max_val = Long.MIN_VALUE / 2;

        // Option 1: The element nums[mid-1] is not part of the k_val-th subarray.
        // In this case, dp[k_val][mid] is dp[k_val][mid-1].
        // This is handled by initializing max_val with dp[k_val][mid-1].
        // If mid == 0, dp[k_val][mid-1] is not valid, but mid starts from currentK, so mid-1 >= 0.
        if (mid > 0) { // This condition is actually mid >= currentK, so mid-1 >= currentK-1 >= 0
            max_val = dp[k_val][mid - 1];
        }

        // Option 2: The element nums[mid-1] is the end of the k_val-th subarray.
        // The k_val-th subarray starts at j_start and ends at mid-1.
        // The previous k_val-1 subarrays must consider elements up to j_start-1.
        // So we need dp[k_val-1][j_start].
        // j_start must be at least k_val-1 to form k_val-1 previous subarrays.
        // j_start must be less than mid to form a non-empty k_val-th subarray.
        int actual_j_low = Math.max(j_low, k_val - 1);
        int actual_j_high = Math.min(j_high, mid - 1);

        for (int j_start = actual_j_low; j_start <= actual_j_high; ++j_start) {
            // Check if the previous state is valid (not -infinity).
            if (dp[k_val - 1][j_start] == Long.MIN_VALUE / 2) {
                continue;
            }

            // Calculate strength of the current k_val-th subarray: nums[j_start ... mid-1]
            long currentSubarraySum = prefixSum[mid] - prefixSum[j_start];
            long currentSubarrayLength = mid - j_start;
            long currentSubarrayStrength = currentSubarraySum * currentSubarrayLength;

            // Total strength for this choice of j_start
            long currentTotalStrength = dp[k_val - 1][j_start] + currentSubarrayStrength;

            if (currentTotalStrength > max_val) {
                max_val = currentTotalStrength;
                best_j_start = j_start;
            }
        }

        dp[k_val][mid] = max_val;

        // Recursively solve for the left and right halves.
        // The optimal j_start for dp[k_val][i] for i < mid is in [j_low, best_j_start].
        solve(k_val, i_low, mid - 1, j_low, best_j_start);
        // The optimal j_start for dp[k_val][i] for i > mid is in [best_j_start, j_high].
        solve(k_val, mid + 1, i_high, best_j_start, j_high);
    }
}