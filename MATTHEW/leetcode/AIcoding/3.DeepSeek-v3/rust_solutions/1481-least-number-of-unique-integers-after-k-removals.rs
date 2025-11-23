use std::collections::HashMap;

impl Solution {
    pub fn find_least_num_of_unique_ints(arr: Vec<i32>, k: i32) -> i32 {
        let mut freq_map = HashMap::new();
        for num in arr {
            *freq_map.entry(num).or_insert(0) += 1;
        }
        let mut freqs: Vec<i32> = freq_map.values().cloned().collect();
        freqs.sort_unstable();
        let mut remaining_removals = k;
        let mut unique_count = freqs.len() as i32;
        for &freq in freqs.iter() {
            if remaining_removals >= freq {
                remaining_removals -= freq;
                unique_count -= 1;
            } else {
                break;
            }
        }
        unique_count
    }
}