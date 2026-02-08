impl Solution {
    pub fn number_of_stable_arrays(zero: i32, one: i32, limit: i32) -> i32 {
        const MOD: i64 = 1_000_000_007;
        let zero = zero as usize;
        let one = one as usize;
        let limit = limit as usize;
        let total = zero + one;
        let mut dp = vec![vec![vec![0; 2]; one + 1]; zero + 1];
        dp[0][0][0] = 1;
        dp[0][0][1] = 1;

        for s in 1..=total {
            for z in 0..=zero.min(s) {
                let o = s - z;
                if o > one {
                    continue;
                }
                for k in 0..2 {
                    let mut res = 0;
                    if k == 0 && z > 0 {
                        let max_prev_z = (z - 1).min(limit - 1);
                        for prev_z in z.saturating_sub(max_prev_z + 1)..z {
                            let prev_o = s - 1 - prev_z;
                            if prev_o <= one {
                                res = (res + dp[prev_z][prev_o][1]) % MOD;
                            }
                        }
                    } else if k == 1 && o > 0 {
                        let max_prev_o = (o - 1).min(limit - 1);
                        for prev_o in o.saturating_sub(max_prev_o + 1)..o {
                            let prev_z = s - 1 - prev_o;
                            if prev_z <= zero {
                                res = (res + dp[prev_z][prev_o][0]) % MOD;
                            }
                        }
                    }
                    dp[z][o][k] = res;
                }
            }
        }
        ((dp[zero][one][0] + dp[zero][one][1]) % MOD) as i32
    }
}