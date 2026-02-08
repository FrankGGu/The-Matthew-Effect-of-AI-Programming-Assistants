const MOD: i64 = 1_000_000_007;

impl Solution {
    pub fn die_simulator(n: i32, roll_max: Vec<i32>) -> i32 {
        let n = n as usize;
        let mut dp = vec![vec![0; 6]; n + 1];
        let mut sum = vec![0; n + 1];

        sum[0] = 1;

        for i in 1..=n {
            for j in 0..6 {
                for k in 1..=roll_max[j] + 1 {
                    if i as i32 - k as i32 >= 0 {
                        dp[i][j] = (dp[i][j] + sum[i - k]) % MOD;
                        if i - k > 0 {
                            dp[i][j] = (dp[i][j] - (sum[i - k - 1] - dp[i - k - 1][j] + MOD) % MOD + MOD) % MOD;
                        } else {
                            dp[i][j] = (dp[i][j] - 0 + MOD) % MOD;
                        }
                    }
                }
                sum[i] = (sum[i] + dp[i][j]) % MOD;
            }
        }

        sum[n] as i32
    }
}