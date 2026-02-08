pub fn number_of_sets(n: i32, k: i32) -> i32 {
    const MOD: i32 = 1_000_000_007;
    let k = k as usize;
    let n = n as usize;
    let mut dp = vec![vec![0; k + 1]; n + 1];

    for i in 0..=n {
        dp[i][0] = 1;
    }

    for j in 1..=k {
        for i in j..=n {
            dp[i][j] = (dp[i - 1][j] + dp[i - 1][j - 1] * (i as i32 - j as i32 + 1) % MOD) % MOD;
        }
    }

    dp[n][k]
}