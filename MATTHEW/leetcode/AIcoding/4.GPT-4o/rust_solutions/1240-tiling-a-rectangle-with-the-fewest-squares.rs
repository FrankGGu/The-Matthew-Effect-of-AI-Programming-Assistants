impl Solution {
    pub fn tiling_rectangle(n: i32, m: i32) -> i32 {
        let mut dp = vec![vec![i32::MAX; m as usize + 1]; n as usize + 1];
        dp[0][0] = 0;

        for i in 1..=n as usize {
            for j in 1..=m as usize {
                for k in 1..=i.min(j) {
                    dp[i][j] = dp[i][j].min(dp[i - k][j] + dp[k][j - k] + 1);
                }
            }
        }

        dp[n as usize][m as usize]
    }
}