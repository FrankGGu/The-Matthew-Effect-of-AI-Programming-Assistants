impl Solution {

use std::collections::HashSet;

impl Solution {
    pub fn find_valid_split(s: String) -> i32 {
        let mut left = HashSet::new();
        let mut right = HashSet::new();

        for c in s.chars() {
            right.insert(c);
        }

        for (i, c) in s.chars().enumerate() {
            left.insert(c);
            right.remove(&c);
            if left == right {
                return i as i32;
            }
        }

        -1
    }
}
}