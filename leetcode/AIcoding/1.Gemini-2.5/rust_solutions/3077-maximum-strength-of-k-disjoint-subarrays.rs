struct Solution;

impl Solution {
    pub fn max_strength(nums: Vec<i32>, k: i32) -> i64 {
        let n = nums.len();
        let k_usize = k as usize;

        // dp[j][0]: maximum strength using `j` subarrays, where the `j`-th subarray ends at the current element.
        // dp[j][1]: maximum strength using `j` subarrays, where the `j`-th subarray has already been completed (ends before or at current element).
        // Initialize with a very small number to represent negative infinity, to handle cases where no valid subarray can be formed.
        // i64::MIN / 2 is used to prevent overflow when adding positive numbers to MIN_INF.
        let min_inf = i64::MIN / 2;

        let mut dp: Vec<[i64; 2]> = vec![[min_inf, min_inf]; k_usize + 1];

        // Base case: 0 subarrays completed, strength is 0.
        dp[0][1] = 0;

        for &num in nums.iter() {
            for j in (1..=k_usize).rev() {
                // Calculate sign for the j-th subarray based on the problem description:
                // "sign is 1 if k - (number of subarrays chosen so far) is odd, and -1 if it is even."
                // Here, 'number of subarrays chosen so far' is j.
                // So, if (k - j) is odd, sign is 1. If (k - j) is even, sign is -1.
                let sign = if (k - j) % 2 == 1 { 1 } else { -1 };
                let val = num as i64 * sign;

                // Update dp[j][0]:
                // Option 1: Extend the j-th subarray from the previous element.
                //           This means taking the previous dp[j][0] and adding current 'val'.
                // Option 2: Start a new j-th subarray at the current element.
                //           This means taking the max strength of j-1 completed subarrays (dp[j-1][1])
                //           and adding current 'val' to start a new j-th subarray.
                dp[j][0] = (dp[j][0] + val).max(dp[j-1][1] + val);

                // Update dp[j][1]:
                // Option 1: The j-th subarray was already completed before the current element.
                //           This means taking the previous dp[j][1].
                // Option 2: The j-th subarray was completed *at* the current element.
                //           This means taking the newly calculated dp[j][0] for the current element.
                dp[j][1] = dp[j][1].max(dp[j][0]);
            }
        }

        // The maximum strength using k disjoint subarrays is dp[k][1],
        // as it represents the maximum strength having completed k subarrays by any point.
        dp[k_usize][1]
    }
}