pub fn die_simulator(n: i32, roll_max: Vec<i32>) -> i32 {
    const MOD: i32 = 1_000_000_007;
    let mut dp = vec![vec![0; 7]; n as usize + 1];
    let mut sum = vec![0; n as usize + 1];

    dp[0][0] = 1;

    for i in 1..=n as usize {
        for j in 1..=6 {
            for k in 1..=roll_max[j as usize - 1].min(i as i32) {
                dp[i][j] = (dp[i][j] + dp[i - k][0]) % MOD;
            }
            dp[i][0] = (dp[i][0] + dp[i][j]) % MOD;
        }
    }

    for i in 1..=n as usize {
        sum[i] = (sum[i - 1] + dp[i][0]) % MOD;
    }

    sum[n as usize]
}