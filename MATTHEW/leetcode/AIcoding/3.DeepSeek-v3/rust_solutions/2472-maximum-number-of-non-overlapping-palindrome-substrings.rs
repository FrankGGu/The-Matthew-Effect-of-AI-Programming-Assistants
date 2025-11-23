impl Solution {
    pub fn max_palindromes(s: String, k: i32) -> i32 {
        let s = s.as_bytes();
        let n = s.len();
        let k = k as usize;
        let mut dp = vec![false; n + 1];
        dp[0] = true;
        let mut res = 0;
        for i in 0..n {
            if i > 0 && dp[i - 1] {
                res += 1;
                dp[i + 1] = true;
                continue;
            }
            for l in k..=(i + 1).min(2 * k + 1) {
                if l > i + 1 {
                    break;
                }
                let start = i + 1 - l;
                if Self::is_palindrome(&s[start..=i]) {
                    res += 1;
                    dp[i + 1] = true;
                    break;
                }
            }
        }
        res
    }

    fn is_palindrome(s: &[u8]) -> bool {
        let n = s.len();
        for i in 0..n / 2 {
            if s[i] != s[n - 1 - i] {
                return false;
            }
        }
        true
    }
}