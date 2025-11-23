impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn maximum_deletions(s: String) -> i32 {
        let mut freq = HashMap::new();
        for c in s.chars() {
            *freq.entry(c).or_insert(0) += 1;
        }

        let mut counts = Vec::new();
        for &v in freq.values() {
            counts.push(v);
        }
        counts.sort_by(|a, b| b.cmp(a));

        let mut result = 0;
        let mut current = 0;
        for &count in &counts {
            if current < count {
                result += 1;
                current = count;
            }
        }

        result
    }
}
}