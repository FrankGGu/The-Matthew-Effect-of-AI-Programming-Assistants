impl Solution {
    pub fn special_substring(s: String, k: usize) -> String {
        let n = s.len();
        if n < k {
            return "".to_string();
        }

        let mut max_substring = "".to_string();
        for i in 0..=n - k {
            let substring = &s[i..i + k];
            let unique_chars: std::collections::HashSet<_> = substring.chars().collect();
            if unique_chars.len() == k {
                if substring > max_substring {
                    max_substring = substring.to_string();
                }
            }
        }
        max_substring
    }
}