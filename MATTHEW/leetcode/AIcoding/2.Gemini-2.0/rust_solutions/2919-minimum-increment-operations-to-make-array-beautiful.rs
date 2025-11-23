impl Solution {
    pub fn min_increment_operations(nums: Vec<i32>, k: i32) -> i64 {
        let n = nums.len();
        let mut dp = vec![0; n + 1];

        for i in 1..=n {
            if i <= 3 {
                let mut max_val = 0;
                for j in 1..=i {
                    max_val = max_val.max(nums[i - j]);
                }
                dp[i] = max_val.max(k) as i64;
            } else {
                let mut max_val = nums[i - 1].max(nums[i - 2]).max(nums[i - 3]);
                dp[i] = (dp[i - 1]).min(dp[i - 2]).min(dp[i - 3]) + max_val.max(k) as i64;
            }
        }

        dp[n]
    }
}