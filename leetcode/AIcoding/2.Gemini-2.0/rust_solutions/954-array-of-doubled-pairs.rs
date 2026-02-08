use std::collections::HashMap;

impl Solution {
    pub fn can_reorder_doubled(arr: Vec<i32>) -> bool {
        let mut counts = HashMap::new();
        for &x in &arr {
            *counts.entry(x).or_insert(0) += 1;
        }

        let mut nums: Vec<i32> = counts.keys().cloned().collect();
        nums.sort_by_key(|&x| x.abs());

        for &x in &nums {
            let count = *counts.get(&x).unwrap_or(&0);
            if count == 0 {
                continue;
            }

            let target = if x >= 0 { x * 2 } else { x * 2 };

            if !counts.contains_key(&target) {
                return false;
            }

            let target_count = *counts.get(&target).unwrap_or(&0);

            if target_count < count {
                return false;
            }

            *counts.get_mut(&x).unwrap() -= count;
            *counts.get_mut(&target).unwrap() -= count;
        }

        true
    }
}