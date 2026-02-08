mod Solution {
    pub fn ideal_arrays(n: i32, max_value: i32) -> i32 {
        const MOD: i32 = 1_000_000_007;
        let mut dp = vec![0; (max_value + 1) as usize];
        let mut cnt = vec![0; (max_value + 1) as usize];

        for i in 1..=max_value {
            dp[i as usize] = 1;
            for j in (2 * i..=max_value).step_by(i as usize) {
                dp[j as usize] = (dp[j as usize] + dp[i as usize]) % MOD;
            }
        }

        for i in 1..=max_value {
            cnt[i as usize] = (dp[i as usize] * n as i64 % MOD) as i32;
        }

        let mut result = 0;
        for i in 1..=max_value {
            result = (result + cnt[i as usize]) % MOD;
        }

        result
    }
}