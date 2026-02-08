impl Solution {
    pub fn minimum_array_sum(nums: Vec<i32>) -> i64 {
        let n = nums.len();
        let mut nums = nums;
        nums.sort();
        let mut prefix_sum: Vec<i64> = vec![0; n + 1];
        for i in 0..n {
            prefix_sum[i + 1] = prefix_sum[i] + nums[i] as i64;
        }
        let mut dp: Vec<i64> = vec![0; n];
        dp[0] = nums[0] as i64;
        for i in 1..n {
            dp[i] = dp[i - 1].max(nums[i] as i64);
        }
        dp[n - 1]
    }
}