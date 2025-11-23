impl Solution {
    pub fn longest_semi_repetitive_substring(s: String) -> i32 {
        let s = s.as_bytes();
        let n = s.len();
        let mut max_len = 1;
        let mut left = 0;
        let mut last_pair = None;

        for right in 1..n {
            if s[right] == s[right - 1] {
                if let Some(pos) = last_pair {
                    left = pos + 1;
                }
                last_pair = Some(right);
            }
            max_len = max_len.max((right - left + 1) as i32);
        }

        max_len
    }
}