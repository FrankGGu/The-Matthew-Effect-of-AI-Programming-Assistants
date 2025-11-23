impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn min_groups(beans: Vec<i32>) -> i32 {
        let mut freq = HashMap::new();
        for &b in &beans {
            *freq.entry(b).or_insert(0) += 1;
        }

        let mut sorted_keys: Vec<_> = freq.keys().cloned().collect();
        sorted_keys.sort();

        let mut result = i32::MAX;
        for &key in &sorted_keys {
            let mut groups = 0;
            for &k in &sorted_keys {
                if k == key {
                    continue;
                }
                let count = freq[&k];
                let diff = key - k;
                if diff > 0 {
                    groups += (count * diff) as i32;
                }
            }
            result = result.min(groups);
        }

        result
    }
}
}