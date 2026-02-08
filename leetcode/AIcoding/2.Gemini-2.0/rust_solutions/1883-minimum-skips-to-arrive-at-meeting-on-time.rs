impl Solution {
    pub fn min_skips(dist: Vec<i32>, speed: i32, hours_before: i32) -> i32 {
        let n = dist.len();
        let hours_before = hours_before as f64;

        let mut dp = vec![vec![f64::MAX; n + 1]; n + 1];
        dp[0][0] = 0.0;

        for i in 0..n {
            for j in 0..=i {
                if dp[i][j] == f64::MAX {
                    continue;
                }

                // Skip
                dp[i + 1][j + 1] = dp[i + 1][j + 1].min(dp[i][j]);

                // No Skip
                let time = (dp[i][j] + dist[i] as f64 / speed as f64).ceil();
                dp[i + 1][j] = dp[i + 1][j].min(time);
            }
        }

        for j in 0..=n {
            if dp[n][j] <= hours_before {
                return j as i32;
            }
        }

        -1
    }
}