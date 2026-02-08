impl Solution {
    pub fn rearrange_sticks(n: i32, k: i32) -> i32 {
        let n = n as usize;
        let k = k as usize;
        let modulo = 1_000_000_007;

        let mut dp = vec![vec![0; k + 1]; n + 1];

        dp[0][0] = 1;

        for i in 1..=n {
            for j in 1..=k {
                let term1 = dp[i - 1][j - 1];
                let term2 = (dp[i - 1][j] as i64 * (i - 1) as i64) % modulo;
                dp[i][j] = ((term1 as i64 + term2) % modulo) as i32;
            }
        }

        dp[n][k]
    }
}