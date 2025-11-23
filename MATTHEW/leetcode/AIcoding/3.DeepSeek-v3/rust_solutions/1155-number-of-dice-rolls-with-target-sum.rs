impl Solution {
    pub fn num_rolls_to_target(n: i32, k: i32, target: i32) -> i32 {
        let n = n as usize;
        let k = k as usize;
        let target = target as usize;
        let modulo = 1_000_000_007;
        let mut dp = vec![vec![0; target + 1]; n + 1];
        dp[0][0] = 1;

        for i in 1..=n {
            for j in 1..=target {
                for face in 1..=k {
                    if j >= face {
                        dp[i][j] = (dp[i][j] + dp[i - 1][j - face]) % modulo;
                    }
                }
            }
        }

        dp[n][target]
    }
}