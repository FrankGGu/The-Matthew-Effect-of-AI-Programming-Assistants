impl Solution {
    pub fn selling_wood(m: i32, n: i32, prices: Vec<Vec<i32>>) -> i64 {
        let m = m as usize;
        let n = n as usize;
        let mut dp = vec![vec![0; n + 1]; m + 1];

        for price in &prices {
            let h = price[0] as usize;
            let w = price[1] as usize;
            let p = price[2] as i64;
            dp[h][w] = p;
        }

        for i in 1..=m {
            for j in 1..=n {
                for k in 1..=i / 2 + 1 {
                    dp[i][j] = dp[i][j].max(dp[k][j] + dp[i - k][j]);
                }
                for k in 1..=j / 2 + 1 {
                    dp[i][j] = dp[i][j].max(dp[i][k] + dp[i][j - k]);
                }
            }
        }

        dp[m][n]
    }
}