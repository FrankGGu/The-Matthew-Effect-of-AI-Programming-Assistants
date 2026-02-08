impl Solution {
    pub fn count_vowel_permutation(n: i32) -> i32 {
        let n = n as usize;
        let modulo = 1_000_000_007;
        let mut dp = vec![vec![0; 5]; n + 1];

        for j in 0..5 {
            dp[1][j] = 1;
        }

        for i in 2..=n {
            dp[i][0] = ((dp[i-1][1] + dp[i-1][2]) % modulo + dp[i-1][4]) % modulo;
            dp[i][1] = (dp[i-1][0] + dp[i-1][2]) % modulo;
            dp[i][2] = (dp[i-1][1] + dp[i-1][3]) % modulo;
            dp[i][3] = dp[i-1][2] % modulo;
            dp[i][4] = (dp[i-1][2] + dp[i-1][3]) % modulo;
        }

        let mut result = 0;
        for j in 0..5 {
            result = (result + dp[n][j]) % modulo;
        }

        result
    }
}