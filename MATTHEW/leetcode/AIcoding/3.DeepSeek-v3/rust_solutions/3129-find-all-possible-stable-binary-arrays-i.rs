impl Solution {
    pub fn number_of_stable_arrays(zero: i32, one: i32, limit: i32) -> i32 {
        const MOD: i32 = 1_000_000_007;
        let mut dp = vec![vec![vec![0; 2]; (one + 1) as usize]; (zero + 1) as usize];
        dp[0][0][0] = 1;
        dp[0][0][1] = 1;

        for z in 0..=zero as usize {
            for o in 0..=one as usize {
                if z == 0 && o == 0 {
                    continue;
                }
                let mut res0 = 0;
                if z > 0 {
                    res0 = dp[z - 1][o][1];
                    if z > limit as usize {
                        res0 = (res0 - dp[z - limit as usize - 1][o][1] + MOD) % MOD;
                    }
                }
                let mut res1 = 0;
                if o > 0 {
                    res1 = dp[z][o - 1][0];
                    if o > limit as usize {
                        res1 = (res1 - dp[z][o - limit as usize - 1][0] + MOD) % MOD;
                    }
                }
                dp[z][o][0] = res0;
                dp[z][o][1] = res1;
                if z > 0 {
                    dp[z][o][0] = (dp[z][o][0] + dp[z - 1][o][0]) % MOD;
                }
                if o > 0 {
                    dp[z][o][1] = (dp[z][o][1] + dp[z][o - 1][1]) % MOD;
                }
            }
        }
        ((dp[zero as usize][one as usize][0] + dp[zero as usize][one as usize][1]) % MOD) as i32
    }
}