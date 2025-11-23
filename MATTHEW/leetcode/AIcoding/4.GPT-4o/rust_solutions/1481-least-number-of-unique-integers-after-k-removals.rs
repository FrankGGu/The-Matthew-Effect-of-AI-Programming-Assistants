use std::collections::HashMap;

impl Solution {
    pub fn find_least_num_of_unique_ints(arr: Vec<i32>, k: i32) -> i32 {
        let mut count_map = HashMap::new();
        for &num in &arr {
            *count_map.entry(num).or_insert(0) += 1;
        }

        let mut counts: Vec<i32> = count_map.values().cloned().collect();
        counts.sort_unstable();

        let mut unique_count = counts.len() as i32;
        let mut removals = k;

        for count in counts {
            if removals >= count {
                removals -= count;
                unique_count -= 1;
            } else {
                break;
            }
        }

        unique_count
    }
}