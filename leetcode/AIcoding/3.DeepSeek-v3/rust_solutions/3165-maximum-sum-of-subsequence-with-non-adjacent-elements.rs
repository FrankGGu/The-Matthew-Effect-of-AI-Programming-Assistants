impl Solution {
    pub fn maximum_sum_subsequence(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        if n == 0 {
            return 0;
        }
        if n == 1 {
            return nums[0].max(0);
        }

        let mut dp = vec![0; n];
        dp[0] = nums[0].max(0);
        dp[1] = (nums[1].max(dp[0])).max(0);

        for i in 2..n {
            dp[i] = (dp[i - 1].max(dp[i - 2] + nums[i])).max(0)).max(nums[i]);
        }

        dp[n - 1]
    }
}