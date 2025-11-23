impl Solution {
    pub fn distinct_sequences(n: i32) -> i32 {
        let n = n as usize;
        let MOD = 1_000_000_007;
        let mut dp = vec![vec![vec![0; 7]; 7]; n + 1];

        for i in 1..=6 {
            dp[1][0][i] = 1;
        }

        for i in 2..=n {
            for j in 1..=6 {
                for k in 1..=6 {
                    if k != 0 && k != j && Self::gcd(j, k) == 1 {
                        dp[i][j][k] = (dp[i][j][k] + dp[i - 1][0][j]) % MOD;
                    }
                }
            }

            for j in 1..=6 {
                for k in 1..=6 {
                    dp[i][0][k] = (dp[i][0][k] + dp[i][j][k]) % MOD;
                }
            }
        }

        dp[n][0].iter().sum::<i32>() % MOD
    }

    fn gcd(a: i32, b: i32) -> i32 {
        if b == 0 {
            a
        } else {
            Self::gcd(b, a % b)
        }
    }
}