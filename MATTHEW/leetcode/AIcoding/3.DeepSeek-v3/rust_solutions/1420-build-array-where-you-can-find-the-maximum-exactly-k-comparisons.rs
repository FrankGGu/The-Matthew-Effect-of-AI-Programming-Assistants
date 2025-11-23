impl Solution {
    pub fn num_of_arrays(n: i32, m: i32, k: i32) -> i32 {
        const MOD: i32 = 1_000_000_007;
        let (n, m, k) = (n as usize, m as usize, k as usize);
        if k == 0 || k > m {
            return 0;
        }

        let mut dp = vec![vec![vec![0; k + 1]; m + 1]; n + 1];

        for j in 1..=m {
            dp[1][j][1] = 1;
        }

        for i in 1..=n {
            for j in 1..=m {
                for l in 1..=k {
                    if i == 1 && l == 1 {
                        continue;
                    }
                    let mut sum = 0;
                    sum = (sum + dp[i - 1][j][l] as i64 * j as i64) % MOD as i64;
                    for prev_j in 1..j {
                        sum = (sum + dp[i - 1][prev_j][l - 1] as i64) % MOD as i64;
                    }
                    dp[i][j][l] = sum as i32;
                }
            }
        }

        let mut res = 0;
        for j in 1..=m {
            res = (res + dp[n][j][k]) % MOD;
        }
        res
    }
}