impl Solution {
    pub fn max_subarray_num(nums: Vec<i32>, k: i32) -> i32 {
        let n = nums.len();
        let mut dp = vec![0; n + 1];
        let mut prefix_sum = vec![0; n + 1];

        for i in 1..=n {
            prefix_sum[i] = prefix_sum[i - 1] + nums[i - 1];
        }

        for i in 1..=n {
            for j in 0..i {
                if prefix_sum[i] - prefix_sum[j] <= k {
                    dp[i] = dp[i].max(dp[j] + 1);
                }
            }
        }

        dp[n]
    }
}