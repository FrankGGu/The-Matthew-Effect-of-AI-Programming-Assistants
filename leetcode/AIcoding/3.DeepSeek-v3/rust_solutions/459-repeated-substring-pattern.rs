impl Solution {
    pub fn repeated_substring_pattern(s: String) -> bool {
        let n = s.len();
        if n <= 1 {
            return false;
        }
        let s_chars: Vec<char> = s.chars().collect();
        for len in 1..=n / 2 {
            if n % len != 0 {
                continue;
            }
            let pattern = &s_chars[0..len];
            let mut valid = true;
            for i in len..n {
                if s_chars[i] != pattern[i % len] {
                    valid = false;
                    break;
                }
            }
            if valid {
                return true;
            }
        }
        false
    }
}