impl Solution {
    pub fn repeated_substring_pattern(s: String) -> bool {
        let n = s.len();
        for len in 1..=n / 2 {
            if n % len == 0 {
                let sub = &s[0..len];
                let mut repeated = String::new();
                for _ in 0..n / len {
                    repeated.push_str(sub);
                }
                if repeated == s {
                    return true;
                }
            }
        }
        false
    }
}