impl Solution {
    pub fn longest_special_substring(s: String) -> String {
        let n = s.len();
        let mut result = String::new();

        for len in (1..=n / 3).rev() {
            let mut count_map = std::collections::HashMap::new();
            for i in 0..=n - len {
                let substr = &s[i..i + len];
                *count_map.entry(substr).or_insert(0) += 1;
                if count_map[substr] == 3 {
                    result = substr.to_string();
                    break;
                }
            }
            if !result.is_empty() {
                break;
            }
        }

        result
    }
}