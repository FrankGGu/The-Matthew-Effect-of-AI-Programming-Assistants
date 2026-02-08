pub fn minimum_total_distance(locations: Vec<Vec<i32>>, start: i32, finish: i32) -> i32 {
    let n = locations.len();
    let m = locations[0].len();
    let mut dp = vec![vec![i32::MAX; m + 1]; n + 1];
    dp[0][0] = 0;

    for i in 1..=n {
        for j in 0..=m {
            dp[i][j] = dp[i - 1][j];
            if j > 0 {
                let distance = (locations[i - 1][0] - start).abs() + (locations[i - 1][1] - finish).abs();
                dp[i][j] = dp[i][j].min(dp[i - 1][j - 1] + distance);
            }
        }
    }

    (0..=m).map(|j| dp[n][j]).min().unwrap()
}