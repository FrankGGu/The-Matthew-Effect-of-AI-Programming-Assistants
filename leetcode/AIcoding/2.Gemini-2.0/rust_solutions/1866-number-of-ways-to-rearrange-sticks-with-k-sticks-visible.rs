impl Solution {
    pub fn rearrange_sticks(n: i32, k: i32) -> i32 {
        let n = n as usize;
        let k = k as usize;
        let modulo = 1_000_000_007;

        let mut dp = vec![vec![0; k + 1]; n + 1];
        dp[0][0] = 1;

        for i in 1..=n {
            for j in 1..=k {
                dp[i][j] = (dp[i - 1][j - 1] + (i as i64 - 1) * dp[i - 1][j] as i64) % modulo as i64;
                dp[i][j] %= modulo as i64;
            }
        }

        dp[n][k] as i32
    }
}