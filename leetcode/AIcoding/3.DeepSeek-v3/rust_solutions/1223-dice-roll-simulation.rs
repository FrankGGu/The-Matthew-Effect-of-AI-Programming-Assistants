impl Solution {
    pub fn die_simulator(n: i32, roll_max: Vec<i32>) -> i32 {
        const MOD: i32 = 1_000_000_007;
        let n = n as usize;
        let mut dp = vec![vec![vec![0; 16]; 6]; n + 1];

        for j in 0..6 {
            dp[1][j][1] = 1;
        }

        for i in 2..=n {
            for j in 0..6 {
                for k in 1..=roll_max[j] as usize {
                    for prev_j in 0..6 {
                        if prev_j != j {
                            dp[i][j][1] = (dp[i][j][1] + dp[i - 1][prev_j][k]) % MOD;
                        } else if k + 1 <= roll_max[j] as usize {
                            dp[i][j][k + 1] = (dp[i][j][k + 1] + dp[i - 1][j][k]) % MOD;
                        }
                    }
                }
            }
        }

        let mut res = 0;
        for j in 0..6 {
            for k in 1..=roll_max[j] as usize {
                res = (res + dp[n][j][k]) % MOD;
            }
        }
        res
    }
}