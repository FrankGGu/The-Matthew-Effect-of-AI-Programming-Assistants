impl Solution {
    pub fn count_fertile_pyramids(land: Vec<Vec<i32>>) -> i64 {
        let m = land.len();
        let n = land[0].len();
        let mut dp = vec![vec![0; n]; m];
        let mut count = 0;

        for i in 0..m {
            for j in 0..n {
                if land[i][j] == 1 {
                    if i > 0 && j > 0 && j < n - 1 {
                        dp[i][j] = dp[i - 1][j - 1].min(dp[i - 1][j]).min(dp[i - 1][j + 1]) + 1;
                    } else {
                        dp[i][j] = 1;
                    }
                    count += dp[i][j];
                }
            }
        }

        let mut dp_inv = vec![vec![0; n]; m];
        let mut count_inv = 0;

        for i in (0..m).rev() {
            for j in 0..n {
                if land[i][j] == 1 {
                    if i < m - 1 && j > 0 && j < n - 1 {
                        dp_inv[i][j] = dp_inv[i + 1][j - 1].min(dp_inv[i + 1][j]).min(dp_inv[i + 1][j + 1]) + 1;
                    } else {
                        dp_inv[i][j] = 1;
                    }
                    count_inv += dp_inv[i][j];
                }
            }
        }

        count as i64 + count_inv as i64 - (m * n) as i64
    }
}