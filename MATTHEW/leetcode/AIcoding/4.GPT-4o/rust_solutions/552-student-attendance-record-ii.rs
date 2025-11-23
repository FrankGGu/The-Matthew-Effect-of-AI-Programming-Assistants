impl Solution {
    pub fn check_record(n: i32) -> i32 {
        const MOD: i32 = 1_000_000_007;
        let n = n as usize;
        let mut dp = vec![vec![vec![0; 2]; 3]; n + 1];

        dp[0][0][0] = 1;

        for i in 0..n {
            for j in 0..3 {
                for k in 0..2 {
                    let current = dp[i][j][k];
                    dp[i + 1][j][0] = (dp[i + 1][j][0] + current) % MOD; // present
                    if j + 1 < 3 {
                        dp[i + 1][j + 1][0] = (dp[i + 1][j + 1][0] + current) % MOD; // absent
                    }
                    if k == 0 {
                        dp[i + 1][0][1] = (dp[i + 1][0][1] + current) % MOD; // late
                    }
                }
            }
        }

        let mut result = 0;
        for j in 0..3 {
            for k in 0..2 {
                result = (result + dp[n][j][k]) % MOD;
            }
        }

        result
    }
}