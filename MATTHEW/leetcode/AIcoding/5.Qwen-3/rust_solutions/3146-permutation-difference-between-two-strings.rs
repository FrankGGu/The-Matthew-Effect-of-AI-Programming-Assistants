impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn difference(s: String, t: String) -> i32 {
        let mut count = HashMap::new();

        for c in s.chars() {
            *count.entry(c).or_insert(0) += 1;
        }

        for c in t.chars() {
            *count.entry(c).or_insert(0) += 1;
        }

        let mut result = 0;

        for (_, &v) in &count {
            result += v;
        }

        result / 2
    }
}
}