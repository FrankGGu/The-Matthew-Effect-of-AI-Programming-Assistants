impl Solution {
    pub fn strange_printer(s: String) -> i32 {
        if s.is_empty() {
            return 0;
        }

        let mut compressed_s: Vec<char> = Vec::new();
        let s_chars: Vec<char> = s.chars().collect();

        if !s_chars.is_empty() {
            compressed_s.push(s_chars[0]);
            for i in 1..s_chars.len() {
                if s_chars[i] != s_chars[i-1] {
                    compressed_s.push(s_chars[i]);
                }
            }
        }

        let n = compressed_s.len();
        if n == 0 {
            return 0;
        }

        let mut dp: Vec<Vec<i32>> = vec![vec![0; n]; n];

        for i in 0..n {
            dp[i][i] = 1;
        }

        for len in 2..=n {
            for i in 0..=(n - len) {
                let j = i + len - 1;

                dp[i][j] = 1 + dp[i+1][j];

                for k in (i + 1)..=j {
                    if compressed_s[k] == compressed_s[i] {
                        let turns_for_middle = if i + 1 <= k - 1 { dp[i+1][k-1] } else { 0 };
                        let turns_for_rest = if k + 1 <= j { dp[k+1][j] } else { 0 };
                        dp[i][j] = dp[i][j].min(turns_for_middle + turns_for_rest);
                    }
                }
            }
        }

        dp[0][n-1]
    }
}