impl Solution {

use std::collections::HashSet;

impl Solution {
    pub fn partition_string(s: String) -> i32 {
        let mut set = HashSet::new();
        let mut count = 1;

        for c in s.chars() {
            if set.contains(&c) {
                set.clear();
                count += 1;
            }
            set.insert(c);
        }

        count
    }
}
}