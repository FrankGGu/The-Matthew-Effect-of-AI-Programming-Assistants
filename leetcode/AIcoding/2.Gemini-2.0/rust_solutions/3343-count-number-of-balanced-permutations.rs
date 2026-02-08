impl Solution {
    pub fn count_number_of_balanced_permutations(n: i32) -> i32 {
        let n = n as usize;
        let mut dp = vec![vec![0; n + 1]; n + 1];
        dp[0][0] = 1;

        for i in 0..n {
            for j in 0..=i {
                if dp[i][j] > 0 {
                    if j > 0 {
                        dp[i + 1][j - 1] = (dp[i + 1][j - 1] + dp[i][j]) % 1000000007;
                    }
                    dp[i + 1][j + 1] = (dp[i + 1][j + 1] + dp[i][j]) % 1000000007;
                }
            }
        }

        dp[n][0]
    }
}