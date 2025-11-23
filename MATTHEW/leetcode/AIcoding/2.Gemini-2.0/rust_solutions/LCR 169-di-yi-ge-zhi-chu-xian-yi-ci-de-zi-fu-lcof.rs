impl Solution {
    pub fn split_ways(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        let mut dp = vec![0; n];
        dp[0] = nums[0];
        for i in 1..n {
            dp[i] = dp[i - 1] + nums[i];
        }

        let mut ans = 0;
        for i in 0..n - 1 {
            if dp[i] == dp[n - 1] - dp[i] {
                ans += 1;
            }
        }
        ans
    }
}