impl Solution {
    pub fn count_substrings(s: String) -> i32 {
        let n = s.len();
        let s_chars: Vec<char> = s.chars().collect();
        let mut dp = vec![vec![false; n]; n];
        let mut count = 0;

        for i in 0..n {
            dp[i][i] = true;
            count += 1;
        }

        for i in 0..n - 1 {
            if s_chars[i] == s_chars[i + 1] {
                dp[i][i + 1] = true;
                count += 1;
            }
        }

        for len in 3..=n {
            for i in 0..=n - len {
                let j = i + len - 1;
                if s_chars[i] == s_chars[j] && dp[i + 1][j - 1] {
                    dp[i][j] = true;
                    count += 1;
                }
            }
        }

        count
    }
}