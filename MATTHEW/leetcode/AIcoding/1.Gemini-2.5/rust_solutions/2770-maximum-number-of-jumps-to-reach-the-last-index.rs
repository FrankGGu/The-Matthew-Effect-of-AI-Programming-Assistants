impl Solution {
    pub fn maximum_jumps(nums: Vec<i32>, target: i32) -> i32 {
        let n = nums.len();
        let mut dp = vec![-1; n];

        dp[0] = 0; // 0 jumps to reach the starting position

        for i in 0..n {
            if dp[i] == -1 {
                // If index i is unreachable, we cannot jump from it
                continue;
            }

            for j in (i + 1)..n {
                if (nums[i] - nums[j]).abs() <= target {
                    // If we can jump from i to j
                    // Update dp[j] with the maximum jumps
                    dp[j] = std::cmp::max(dp[j], dp[i] + 1);
                }
            }
        }

        dp[n - 1]
    }
}