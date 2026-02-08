impl Solution {
    pub fn ways_to_reach_target(target: i32, types: Vec<Vec<i32>>) -> i32 {
        let target = target as usize;
        let mut dp = vec![0; target + 1];
        dp[0] = 1;
        const MOD: i32 = 1_000_000_007;

        for t in types {
            let count = t[0] as usize;
            let mark = t[1] as usize;
            for i in (0..=target).rev() {
                for k in 1..=count {
                    if i >= k * mark {
                        dp[i] = (dp[i] + dp[i - k * mark]) % MOD;
                    }
                }
            }
        }

        dp[target]
    }
}