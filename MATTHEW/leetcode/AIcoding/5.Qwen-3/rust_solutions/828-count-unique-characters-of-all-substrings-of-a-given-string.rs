impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn unique_letter_count(s: String) -> i32 {
        let mut count = 0;
        let s_chars: Vec<char> = s.chars().collect();
        let n = s_chars.len();

        for i in 0..n {
            let mut freq = HashMap::new();
            for j in i..n {
                *freq.entry(s_chars[j]).or_insert(0) += 1;
                if freq[&s_chars[j]] == 1 {
                    count += 1;
                }
            }
        }

        count
    }
}
}