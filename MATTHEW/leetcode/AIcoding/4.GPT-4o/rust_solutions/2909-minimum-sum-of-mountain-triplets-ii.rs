impl Solution {
    pub fn minimum_sum(mountain: Vec<Vec<i32>>) -> i32 {
        let n = mountain.len();
        let mut dp = vec![vec![0; n]; n];

        for i in 0..n {
            dp[n - 1][i] = mountain[n - 1][i];
        }

        for i in (0..n - 1).rev() {
            for j in 0..=i {
                dp[i][j] = mountain[i][j] + dp[i + 1][j].min(dp[i + 1][j + 1]);
            }
        }

        dp[0][0]
    }
}