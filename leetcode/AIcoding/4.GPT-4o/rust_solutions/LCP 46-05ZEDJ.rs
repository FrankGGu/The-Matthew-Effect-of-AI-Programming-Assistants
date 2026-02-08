pub fn max_revenue(n: i32, a: Vec<i32>, b: Vec<i32>, c: Vec<i32>, d: Vec<i32>) -> i32 {
    let mut dp = vec![0; n as usize + 1];
    for i in 0..a.len() {
        for j in (c[i]..=n).rev() {
            dp[j as usize] = dp[j as usize].max(dp[(j - c[i]) as usize] + a[i]);
        }
    }
    for i in 0..b.len() {
        for j in (d[i]..=n).rev() {
            dp[j as usize] = dp[j as usize].max(dp[(j - d[i]) as usize] + b[i]);
        }
    }
    dp[n as usize]
}