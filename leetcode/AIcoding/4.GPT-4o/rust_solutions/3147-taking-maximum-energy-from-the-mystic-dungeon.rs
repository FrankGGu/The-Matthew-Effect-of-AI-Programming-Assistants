pub fn max_energy(m: Vec<Vec<i32>>) -> i32 {
    let n = m.len();
    let mut dp = vec![vec![0; 2]; n];

    dp[0][0] = 0;
    dp[0][1] = m[0][0];

    for i in 1..n {
        dp[i][0] = dp[i - 1][0].max(dp[i - 1][1]);
        dp[i][1] = dp[i - 1][0] + m[i][0];
    }

    dp[n - 1][0].max(dp[n - 1][1])
}