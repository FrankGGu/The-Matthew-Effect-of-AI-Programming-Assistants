impl Solution {
    pub fn number_of_sets(n: i32, k: i32) -> i32 {
        let n = n as usize;
        let k = k as usize;
        let MOD = 1_000_000_007;
        let mut dp = vec![vec![0; k + 1]; n + 1];
        let mut prefix = vec![vec![0; k + 1]; n + 1];

        for i in 2..=n {
            dp[i][1] = i * (i - 1) / 2;
            prefix[i][1] = (prefix[i - 1][1] + dp[i][1]) % MOD;
        }

        for j in 2..=k {
            for i in j + 1..=n {
                dp[i][j] = (prefix[i - 1][j - 1] + dp[i - 1][j]) % MOD;
                prefix[i][j] = (prefix[i - 1][j] + dp[i][j]) % MOD;
            }
        }

        dp[n][k] as i32
    }
}