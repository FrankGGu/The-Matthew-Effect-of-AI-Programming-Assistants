pub fn fitness_plan(n: i32, points: Vec<i32>, temp: i32) -> i32 {
    let mut dp = vec![0; n as usize + 1];
    for i in 1..=n {
        dp[i as usize] = dp[i as usize - 1];
        for j in 0..points.len() {
            if i >= points[j] {
                dp[i as usize] = dp[i as usize].max(dp[(i - points[j]) as usize] + points[j]);
            }
        }
        if i >= temp {
            dp[i as usize] = dp[i as usize].max(dp[(i - temp) as usize] + temp);
        }
    }
    dp[n as usize]
}