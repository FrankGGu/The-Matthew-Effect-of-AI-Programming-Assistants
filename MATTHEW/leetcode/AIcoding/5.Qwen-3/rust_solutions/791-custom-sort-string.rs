impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn custom_sort_string(s: String, mut t: String) -> String {
        let mut count = HashMap::new();
        for c in t.chars() {
            *count.entry(c).or_insert(0) += 1;
        }

        let mut result = String::new();
        for c in s.chars() {
            if let Some(&n) = count.get(&c) {
                result.push_str(&c.to_string().repeat(n));
                count.remove(&c);
            }
        }

        for (c, &n) in count.iter() {
            result.push_str(&c.to_string().repeat(n));
        }

        result
    }
}
}