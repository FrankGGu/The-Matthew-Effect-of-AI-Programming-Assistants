impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn max_moves_to_end(s: String) -> i32 {
        let mut count = HashMap::new();
        let mut ones = 0;
        for c in s.chars() {
            if c == '1' {
                ones += 1;
            } else {
                *count.entry(c).or_insert(0) += 1;
            }
        }

        let mut result = 0;
        for (c, &v) in count {
            result += v * (ones);
        }

        result
    }
}
}