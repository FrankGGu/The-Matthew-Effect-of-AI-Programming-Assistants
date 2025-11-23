impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn number_of_special_chars(s: String) -> i32 {
        let mut count = 0;
        let mut lower = HashMap::new();
        let mut upper = HashMap::new();

        for c in s.chars() {
            if c.is_lowercase() {
                *lower.entry(c).or_insert(0) += 1;
            } else if c.is_uppercase() {
                *upper.entry(c).or_insert(0) += 1;
            }
        }

        for (c, &cnt) in lower.iter() {
            let upper_c = c.to_ascii_uppercase();
            if let Some(&upper_cnt) = upper.get(&upper_c) {
                if cnt == upper_cnt {
                    count += cnt;
                }
            }
        }

        count
    }
}
}