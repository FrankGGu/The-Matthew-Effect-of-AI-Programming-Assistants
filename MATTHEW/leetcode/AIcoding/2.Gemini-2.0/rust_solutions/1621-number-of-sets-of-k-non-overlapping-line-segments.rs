impl Solution {
    pub fn number_of_sets(n: i32, k: i32) -> i32 {
        let n = n as usize;
        let k = k as usize;
        let modulo: i64 = 1_000_000_007;

        let mut dp = vec![vec![vec![0; 2]; k + 1]; n];

        for i in 0..n {
            dp[i][0][0] = 1;
        }

        for j in 1..=k {
            for i in 1..n {
                dp[i][j][0] = (dp[i - 1][j][0] + dp[i - 1][j][1]) % modulo;
                dp[i][j][1] = (dp[i - 1][j][1] + dp[i - 1][j - 1][0] + dp[i - 1][j - 1][1]) % modulo;
            }
        }

        (dp[n - 1][k][0] + dp[n - 1][k][1]) as i32
    }
}