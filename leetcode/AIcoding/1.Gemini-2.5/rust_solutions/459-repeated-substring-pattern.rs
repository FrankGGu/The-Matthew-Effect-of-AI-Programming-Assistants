impl Solution {
    pub fn repeated_substring_pattern(s: String) -> bool {
        let n = s.len();
        if n == 0 {
            return false;
        }

        let s_plus_s = format!("{}{}", s, s);
        let sub_s_plus_s = &s_plus_s[1..2 * n - 1];

        sub_s_plus_s.contains(&s)
    }
}