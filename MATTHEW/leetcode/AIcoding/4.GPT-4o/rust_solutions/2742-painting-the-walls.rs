pub fn paint_walls(n: i32, costs: Vec<Vec<i32>>) -> i32 {
    let mut dp = costs.clone();
    for i in 1..n as usize {
        for j in 0..3 {
            dp[i][j] += dp[i - 1][(j + 1) % 3].min(dp[i - 1][(j + 2) % 3]);
        }
    }
    dp[(n - 1) as usize].iter().cloned().min().unwrap()
}