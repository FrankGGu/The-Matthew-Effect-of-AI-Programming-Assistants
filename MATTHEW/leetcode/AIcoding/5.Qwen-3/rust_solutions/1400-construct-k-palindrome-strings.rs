impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn can_construct(s: String, k: i32) -> bool {
        if s.len() < k as usize {
            return false;
        }
        let mut counts = HashMap::new();
        for c in s.chars() {
            *counts.entry(c).or_insert(0) += 1;
        }
        let mut odd_count = 0;
        for &count in counts.values() {
            if count % 2 != 0 {
                odd_count += 1;
            }
        }
        odd_count <= k as usize
    }
}
}