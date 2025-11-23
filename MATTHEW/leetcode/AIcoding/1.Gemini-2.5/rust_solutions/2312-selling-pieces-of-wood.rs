impl Solution {
    pub fn selling_wood(m: i32, n: i32, prices: Vec<Vec<i32>>) -> i64 {
        let h_max_usize = m as usize;
        let w_max_usize = n as usize;

        let mut dp = vec![vec![0i64; w_max_usize + 1]; h_max_usize + 1];

        for price_entry in prices {
            let h = price_entry[0] as usize;
            let w = price_entry[1] as usize;
            let p = price_entry[2] as i64;
            if h <= h_max_usize && w <= w_max_usize {
                dp[h][w] = dp[h][w].max(p);
            }
        }

        for h_curr in 1..=h_max_usize {
            for w_curr in 1..=w_max_usize {
                // Consider horizontal cuts
                for i in 1..=h_curr / 2 {
                    dp[h_curr][w_curr] = dp[h_curr][w_curr].max(dp[i][w_curr] + dp[h_curr - i][w_curr]);
                }
                // Consider vertical cuts
                for j in 1..=w_curr / 2 {
                    dp[h_curr][w_curr] = dp[h_curr][w_curr].max(dp[h_curr][j] + dp[h_curr][w_curr - j]);
                }
            }
        }

        dp[h_max_usize][w_max_usize]
    }
}