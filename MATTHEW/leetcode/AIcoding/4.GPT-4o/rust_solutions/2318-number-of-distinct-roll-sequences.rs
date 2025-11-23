impl Solution {
    pub fn distinct_roll_sequences(n: i32, k: i32) -> i32 {
        const MOD: i32 = 1_000_000_007;
        let mut dp = vec![vec![0; k as usize + 1]; n as usize + 1];
        dp[0][0] = 1;

        for i in 1..=n as usize {
            for j in 1..=k as usize {
                for l in 1..=k as usize {
                    if l != j {
                        dp[i][j] = (dp[i][j] + dp[i - 1][l]) % MOD;
                    }
                }
            }
        }

        let mut result = 0;
        for j in 1..=k as usize {
            result = (result + dp[n as usize][j]) % MOD;
        }

        result
    }
}