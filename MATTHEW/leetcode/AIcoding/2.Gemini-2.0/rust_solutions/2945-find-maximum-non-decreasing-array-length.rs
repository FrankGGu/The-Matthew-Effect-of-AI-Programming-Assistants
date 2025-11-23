impl Solution {
    pub fn find_maximum_non_decreasing_array_length(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        let mut prefix_sum = vec![0; n + 1];
        for i in 0..n {
            prefix_sum[i + 1] = prefix_sum[i] + nums[i] as i64;
        }

        let mut dp = vec![0; n];
        dp[0] = 1;
        let mut best = 1;

        for i in 1..n {
            for j in (0..i).rev() {
                if dp[j] > 0 && prefix_sum[i + 1] - prefix_sum[j + 1] >= prefix_sum[j + 1] - prefix_sum[0] {
                    dp[i] = dp[j] + 1;
                    break;
                }
            }
            if prefix_sum[i + 1] >= prefix_sum[i] as i64 {
                dp[i] = std::cmp::max(dp[i], 1);
            }

            best = std::cmp::max(best, dp[i]);
        }

        best
    }
}