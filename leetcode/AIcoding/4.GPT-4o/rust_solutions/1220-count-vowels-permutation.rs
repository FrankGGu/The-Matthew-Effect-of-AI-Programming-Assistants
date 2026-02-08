impl Solution {
    pub fn count_vowel_permutation(n: i32) -> i32 {
        let mod_val = 1_000_000_007;
        let mut dp = vec![1; 5];

        for _ in 1..n {
            let a = dp[0];
            let e = dp[1];
            let i = dp[2];
            let o = dp[3];
            let u = dp[4];
            dp[0] = (e + i + u) % mod_val;
            dp[1] = (a + i) % mod_val;
            dp[2] = (e + o) % mod_val;
            dp[3] = (i) % mod_val;
            dp[4] = (i + o) % mod_val;
        }

        dp.iter().sum::<i32>() % mod_val
    }
}