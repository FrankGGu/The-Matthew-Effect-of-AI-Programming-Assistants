impl Solution {
    pub fn count_vowel_strings(n: i32) -> i32 {
        let n = n as usize;
        let mut dp = vec![vec![0; 5]; n + 1];

        for i in 0..5 {
            dp[1][i] = 1;
        }

        for i in 2..=n {
            for j in 0..5 {
                for k in 0..=j {
                    dp[i][j] += dp[i - 1][k];
                }
            }
        }

        let mut sum = 0;
        for i in 0..5 {
            sum += dp[n][i];
        }

        sum
    }
}