impl Solution {
    pub fn longest_alternating_groups3(n: i32) -> i32 {
        if n <= 2 {
            return n;
        }
        let mut dp = vec![vec![0; 2]; n as usize];
        dp[0][0] = 1;
        dp[0][1] = 1;

        for i in 1..n as usize {
            dp[i][0] = dp[i - 1][1] + 1;
            dp[i][1] = dp[i - 1][0] + 1;
        }

        std::cmp::max(dp[(n - 1) as usize][0], dp[(n - 1) as usize][1])
    }
}