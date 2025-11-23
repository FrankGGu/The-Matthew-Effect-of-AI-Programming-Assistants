impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn h_index(citations: Vec<i32>) -> i32 {
        let mut count = HashMap::new();
        for &c in &citations {
            *count.entry(c).or_insert(0) += 1;
        }
        let mut total = 0;
        for c in (0..=1000).rev() {
            total += count.get(&c).copied().unwrap_or(0);
            if total >= c {
                return c;
            }
        }
        0
    }
}
}