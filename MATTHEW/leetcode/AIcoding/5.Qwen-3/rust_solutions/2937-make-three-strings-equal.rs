impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn min_operations(s: String, t: String, p: String) -> i32 {
        let mut count = HashMap::new();
        for c in s.chars() {
            *count.entry(c).or_insert(0) += 1;
        }
        for c in t.chars() {
            *count.entry(c).or_insert(0) += 1;
        }
        for c in p.chars() {
            *count.entry(c).or_insert(0) += 1;
        }

        let mut res = 0;
        for (_, v) in count {
            if v % 3 != 0 {
                return -1;
            }
            res += v / 3;
        }

        res
    }
}
}