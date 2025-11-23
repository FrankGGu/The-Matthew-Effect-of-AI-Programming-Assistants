impl Solution {
    pub fn longest_special_substring(s: String) -> String {
        let n = s.len();
        let mut result = String::new();

        for len in (1..=n / 3).rev() {
            let mut count = std::collections::HashMap::new();
            for i in 0..=n - len {
                let substring = &s[i..i + len];
                *count.entry(substring).or_insert(0) += 1;
            }
            for (key, &val) in &count {
                if val == 3 {
                    return key.to_string();
                }
            }
        }
        result
    }
}