impl Solution {
    pub fn longest_nice_substring(s: String) -> String {
        let mut max_len = 0;
        let mut result = String::new();
        let n = s.len();

        for i in 0..n {
            for j in i + 1..n + 1 {
                let substring = &s[i..j];
                if Self::is_nice(substring) {
                    if substring.len() > max_len {
                        max_len = substring.len();
                        result = substring.to_string();
                    }
                }
            }
        }
        result
    }

    fn is_nice(subs: &str) -> bool {
        let mut lower = 0;
        let mut upper = 0;
        let mut seen = std::collections::HashSet::new();

        for c in subs.chars() {
            if c.is_lowercase() {
                lower += 1;
                seen.insert(c.to_ascii_uppercase());
            } else if c.is_uppercase() {
                upper += 1;
                seen.insert(c.to_ascii_lowercase());
            }
        }

        lower > 0 && upper > 0 && seen.len() == lower + upper
    }
}