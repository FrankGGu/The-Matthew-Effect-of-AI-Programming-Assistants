impl Solution {
    pub fn distinct_subseq_ii(s: String) -> i32 {
        const MOD: i32 = 1_000_000_007;
        let mut dp = vec![0; 26];
        let mut total = 0;
        for c in s.chars() {
            let idx = (c as u8 - b'a') as usize;
            let prev = dp[idx];
            dp[idx] = (total + 1) % MOD;
            total = ((total + dp[idx] - prev) % MOD + MOD) % MOD;
        }
        total
    }
}