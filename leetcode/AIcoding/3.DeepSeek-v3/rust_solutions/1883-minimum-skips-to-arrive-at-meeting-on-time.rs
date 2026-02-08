impl Solution {
    pub fn min_skips(dist: Vec<i32>, speed: i32, hours_before: i32) -> i32 {
        let n = dist.len();
        let speed = speed as f64;
        let hours_before = hours_before as f64;
        let mut dp = vec![vec![std::f64::INFINITY; n + 1]; n + 1];
        dp[0][0] = 0.0;

        for i in 1..=n {
            let d = dist[i - 1] as f64;
            for j in 0..=i {
                if j < i {
                    let time = (dp[i - 1][j] + d / speed).ceil();
                    dp[i][j] = dp[i][j].min(time);
                }
                if j > 0 {
                    dp[i][j] = dp[i][j].min(dp[i - 1][j - 1] + d / speed);
                }
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