impl Solution {
    pub fn max_dot_product(nums1: Vec<i32>, nums2: Vec<i32>) -> i32 {
        let n = nums1.len();
        let m = nums2.len();

        // dp[i][j] will store the maximum dot product of two non-empty subsequences
        // using elements from nums1[0...i-1] and nums2[0...j-1].
        // Initialize with i32::MIN to represent an invalid or uncomputed state,
        // as dot products can be negative.
        let mut dp = vec![vec![i32::MIN; m + 1]; n + 1];

        for i in 1..=n {
            for j in 1..=m {
                let current_product = nums1[i - 1] * nums2[j - 1];

                // Option 1: Don't include nums1[i-1] in the subsequence from nums1.
                // The max dot product comes from nums1[0...i-2] and nums2[0...j-1].
                let mut max_val = dp[i - 1][j];

                // Option 2: Don't include nums2[j-1] in the subsequence from nums2.
                // The max dot product comes from nums1[0...i-1] and nums2[0...j-2].
                max_val = max_val.max(dp[i][j - 1]);

                // Option 3: Include both nums1[i-1] and nums2[j-1] in their respective subsequences.
                // This pair (nums1[i-1], nums2[j-1]) contributes `current_product`.
                // We can either start a new subsequence with this pair, or extend existing subsequences.
                // If we extend, we add `current_product` to the max dot product from `dp[i-1][j-1]`.
                // If `dp[i-1][j-1]` is `i32::MIN` (meaning no valid previous pairs could be formed),
                // or if `dp[i-1][j-1]` is negative such that adding `current_product` makes it smaller
                // than `current_product` alone, we should just consider `current_product`.
                // `dp[i-1][j-1].max(0)` handles this:
                // - If `dp[i-1][j-1]` is `i32::MIN`, `max(0, i32::MIN)` is `0`. So `current_product + 0 = current_product`.
                // - If `dp[i-1][j-1]` is positive, `max(0, dp[i-1][j-1])` is `dp[i-1][j-1]`. So `current_product + dp[i-1][j-1]`.
                // - If `dp[i-1][j-1]` is negative (but not `i32::MIN`), `max(0, dp[i-1][j-1])` is `0`. So `current_product + 0 = current_product`.
                let val_if_used_both = current_product + dp[i - 1][j - 1].max(0);
                max_val = max_val.max(val_if_used_both);

                dp[i][j] = max_val;
            }
        }

        dp[n][m]
    }
}