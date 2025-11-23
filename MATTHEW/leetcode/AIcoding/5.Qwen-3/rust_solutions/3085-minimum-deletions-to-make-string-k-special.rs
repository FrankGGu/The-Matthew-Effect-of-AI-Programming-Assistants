impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn min_deletions(s: String, k: i32) -> i32 {
        let mut freq = HashMap::new();
        for c in s.chars() {
            *freq.entry(c).or_insert(0) += 1;
        }

        let mut counts = freq.into_values().collect::<Vec<_>>();
        counts.sort_by(|a, b| b.cmp(a));

        let mut deletions = 0;
        let mut max_freq = counts[0];

        for &count in &counts[1..] {
            if count > max_freq {
                deletions += count - max_freq;
            } else {
                max_freq = count;
            }
        }

        deletions
    }
}
}