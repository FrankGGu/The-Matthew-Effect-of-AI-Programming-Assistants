impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn min_operations(s: String) -> i32 {
        let mut freq = HashMap::new();
        for c in s.chars() {
            *freq.entry(c).or_insert(0) += 1;
        }

        let mut counts = freq.values().cloned().collect::<Vec<_>>();
        counts.sort();

        let mut res = 0;
        let target = counts[0];
        for &count in &counts[1..] {
            res += count - target;
        }

        res
    }
}
}