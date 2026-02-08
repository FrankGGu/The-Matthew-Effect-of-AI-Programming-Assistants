impl Solution {
    pub fn num_ways(words: Vec<String>, target: String) -> i32 {
        let target: Vec<char> = target.chars().collect();
        let m = target.len();
        let n = words[0].len();
        let mut count = vec![vec![0; 26]; n];
        for word in words {
            for (i, c) in word.chars().enumerate() {
                count[i][(c as u8 - b'a') as usize] += 1;
            }
        }
        let mut dp = vec![vec![0; n + 1]; m + 1];
        dp[0][0] = 1;
        let modulo = 1_000_000_007;
        for i in 0..=m {
            for j in 0..n {
                if i < m {
                    let c = target[i] as u8 - b'a';
                    dp[i + 1][j + 1] = (dp[i + 1][j + 1] + dp[i][j] as i64 * count[j][c as usize] as i64) % modulo;
                }
                dp[i][j + 1] = (dp[i][j + 1] + dp[i][j]) % modulo;
            }
        }
        dp[m][n] as i32
    }
}