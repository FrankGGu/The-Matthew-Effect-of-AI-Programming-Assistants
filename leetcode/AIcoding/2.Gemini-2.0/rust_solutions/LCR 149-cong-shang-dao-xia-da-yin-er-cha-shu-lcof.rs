impl Solution {
    pub fn record_decoration(heights: Vec<i32>) -> i32 {
        let n = heights.len();
        if n <= 2 {
            return 0;
        }
        let mut dp = vec![0; n];
        dp[1] = (heights[1] - heights[0]).abs();
        for i in 2..n {
            dp[i] = dp[i - 1] + (heights[i] - heights[i - 1]).abs();
            dp[i] = dp[i].min(dp[i - 2] + 3 * (heights[i] - heights[i - 2]).abs());
        }
        dp[n - 1]
    }
}