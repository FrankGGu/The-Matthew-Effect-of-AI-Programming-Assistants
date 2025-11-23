use std::collections::HashMap;

impl Solution {
    pub fn min_groups_for_valid_assignment(nums: Vec<i32>) -> i32 {
        let mut freq = HashMap::new();
        for &num in &nums {
            *freq.entry(num).or_insert(0) += 1;
        }
        let counts: Vec<i32> = freq.values().cloned().collect();
        let min_count = *counts.iter().min().unwrap_or(&0);

        for k in (1..=min_count).rev() {
            let mut total = 0;
            for &cnt in &counts {
                let groups = (cnt + k) / (k + 1);
                let min_elements = groups * k;
                if min_elements > cnt {
                    total = -1;
                    break;
                }
                total += groups;
            }
            if total != -1 {
                return total;
            }
        }
        0
    }
}