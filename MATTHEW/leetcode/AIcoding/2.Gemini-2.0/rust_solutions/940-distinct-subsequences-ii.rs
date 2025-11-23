impl Solution {
    pub fn distinct_subsequences(s: String) -> i32 {
        let n = s.len();
        let s: Vec<char> = s.chars().collect();
        let mut dp = vec![0; n + 1];
        dp[0] = 1;
        let mut last = vec![-1; 26];
        let modulo: i64 = 1_000_000_007;

        for i in 1..=n {
            let c = s[i - 1] as u8 - b'a';
            dp[i] = (2 * dp[i - 1] as i64) % modulo;
            if last[c as usize] != -1 {
                dp[i] = (dp[i] - dp[last[c as usize] as usize] as i64 + modulo) % modulo;
            }
            last[c as usize] = (i - 1) as i32;
        }

        (dp[n] as i64 % modulo) as i32
    }
}