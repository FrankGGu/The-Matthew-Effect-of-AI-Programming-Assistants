use std::collections::HashMap;

impl Solution {
    pub fn most_frequent_ids(ids: Vec<i32>) -> Vec<i32> {
        let mut counts: HashMap<i32, i32> = HashMap::new();
        for id in &ids {
            *counts.entry(*id).or_insert(0) += 1;
        }

        let mut max_count = 0;
        for &count in counts.values() {
            max_count = max_count.max(count);
        }

        let mut result: Vec<i32> = Vec::new();
        for (&id, &count) in &counts {
            if count == max_count {
                result.push(id);
            }
        }

        result.sort();
        result
    }
}

struct Solution;