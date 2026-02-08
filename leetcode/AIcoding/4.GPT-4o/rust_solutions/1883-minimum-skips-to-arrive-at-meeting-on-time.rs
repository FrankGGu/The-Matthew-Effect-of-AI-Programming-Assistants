use std::cmp::Ordering;

pub fn min_skips(dist: Vec<i32>, speed: i32, hours_before: i32) -> i32 {
    let n = dist.len();
    let mut dp = vec![vec![i32::MAX; n + 1]; n + 1];
    dp[0][0] = 0;

    for i in 0..n {
        for j in 0..=i {
            if dp[i][j] != i32::MAX {
                dp[i + 1][j] = (dp[i + 1][j]).min(dp[i][j] + (dist[i] as f64 / speed as f64).ceil() as i32);
                if j + 1 <= n {
                    dp[i + 1][j + 1] = (dp[i + 1][j + 1]).min(dp[i][j] + (dist[i] as f64 / speed as f64).ceil() as i32 - 1);
                }
            }
        }
    }

    for skips in 0..=n {
        if dp[n][skips] <= hours_before {
            return skips;
        }
    }

    -1
}