impl Solution {
    pub fn maximum_total_cost(nums: Vec<i32>) -> i64 {
        let n = nums.len();
        if n == 0 {
            return 0;
        }
        let mut dp = vec![vec![0; 2]; n];
        dp[0][0] = nums[0] as i64;
        dp[0][1] = nums[0] as i64;

        for i in 1..n {
            dp[i][0] = (dp[i-1][1] + nums[i] as i64).max(dp[i-1][0] + nums[i] as i64);
            dp[i][1] = dp[i-1][0] - nums[i] as i64;
        }

        dp[n-1][0].max(dp[n-1][1])
    }
}