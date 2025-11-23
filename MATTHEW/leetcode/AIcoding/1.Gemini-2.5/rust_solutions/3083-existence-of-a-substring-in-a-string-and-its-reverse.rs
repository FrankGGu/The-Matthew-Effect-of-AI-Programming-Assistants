impl Solution {
    pub fn is_substring_present(s: String) -> bool {
        let n = s.len();
        if n < 2 {
            return false;
        }

        let s_rev: String = s.chars().rev().collect();

        for i in 0..n - 1 {
            let sub_str = &s[i..i + 2];
            if s_rev.contains(sub_str) {
                return true;
            }
        }

        false
    }
}