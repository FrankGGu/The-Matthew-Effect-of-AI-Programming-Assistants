impl Solution {

use std::collections::HashMap;

struct Solution;

impl Solution {
    pub fn length_of_longest_substring(s: String) -> i32 {
        let mut map = HashMap::new();
        let mut max_len = 0;
        let mut start = 0;

        for (i, c) in s.chars().enumerate() {
            if let Some(&pos) = map.get(&c) {
                start = std::cmp::max(start, pos + 1);
            }
            map.insert(c, i);
            max_len = std::cmp::max(max_len, i - start + 1);
        }

        max_len as i32
    }
}
}