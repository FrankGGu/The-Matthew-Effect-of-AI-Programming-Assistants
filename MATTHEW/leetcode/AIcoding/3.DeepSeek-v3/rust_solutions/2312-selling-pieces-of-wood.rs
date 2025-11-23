impl Solution {
    pub fn selling_wood(m: i32, n: i32, prices: Vec<Vec<i32>>) -> i64 {
        let m = m as usize;
        let n = n as usize;
        let mut dp = vec![vec![0i64; n + 1]; m + 1];
        let mut price_map = vec![vec![0i64; n + 1]; m + 1];

        for price in prices {
            let h = price[0] as usize;
            let w = price[1] as usize;
            price_map[h][w] = price[2] as i64;
        }

        for i in 1..=m {
            for j in 1..=n {
                dp[i][j] = price_map[i][j];
                for k in 1..i {
                    dp[i][j] = dp[i][j].max(dp[k][j] + dp[i - k][j]);
                }
                for k in 1..j {
                    dp[i][j] = dp[i][j].max(dp[i][k] + dp[i][j - k]);
                }
            }
        }

        dp[m][n]
    }
}