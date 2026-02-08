const MOD: i64 = 1_000_000_007;

impl Solution {
    pub fn num_of_arrays(n: i32, m: i32, k: i32) -> i32 {
        if k > m {
            return 0;
        }

        let n = n as usize;
        let m = m as usize;
        let k = k as usize;

        let mut dp = vec![vec![vec![0; k + 1]; m + 1]; n + 1];
        let mut prefix_sum = vec![vec![vec![0; k + 1]; m + 1]; n + 1];

        for j in 1..=m {
            dp[1][j][1] = 1;
            prefix_sum[1][j][1] = prefix_sum[1][j - 1][1] + 1;
        }

        for i in 2..=n {
            for j in 1..=m {
                for l in 1..=k {
                    dp[i][j][l] = (dp[i][j][l] + (dp[i - 1][j][l] as i64 * j as i64) % MOD) % MOD;
                    dp[i][j][l] = (dp[i][j][l] + prefix_sum[i - 1][j - 1][l - 1]) % MOD;
                }
                for l in 1..=k {
                    prefix_sum[i][j][l] = (prefix_sum[i][j - 1][l] + dp[i][j][l]) % MOD;
                }
            }
        }

        prefix_sum[n][m][k] as i32
    }
}