impl Solution {
    pub fn is_match(s: String, p: String) -> bool {
        fn dp(s: &[u8], p: &[u8], i: usize, j: usize, memo: &mut Vec<Vec<i32>>) -> bool {
            if j == p.len() {
                return i == s.len();
            }
            if memo[i][j] != -1 {
                return memo[i][j] == 1;
            }
            let mut match_found = i < s.len() && (s[i] == p[j] || p[j] == b'.');
            if j + 1 < p.len() && p[j + 1] == b'*' {
                let result = dp(s, p, i, j + 2, memo) || (match_found && dp(s, p, i + 1, j, memo));
                memo[i][j] = if result { 1 } else { 0 };
                return result;
            }
            if match_found && dp(s, p, i + 1, j + 1, memo) {
                memo[i][j] = 1;
                return true;
            }
            memo[i][j] = 0;
            false
        }

        let m = s.len();
        let n = p.len();
        let mut memo = vec![vec![-1; n + 1]; m + 1];
        dp(s.as_bytes(), p.as_bytes(), 0, 0, &mut memo)
    }
}