use std::collections::HashMap;

impl Solution {
    pub fn find_least_num_of_unique_ints(arr: Vec<i32>, k: i32) -> i32 {
        let mut counts: HashMap<i32, i32> = HashMap::new();
        for &num in arr.iter() {
            *counts.entry(num).or_insert(0) += 1;
        }

        let mut frequencies: Vec<i32> = counts.values().cloned().collect();
        frequencies.sort_unstable();

        let mut k_remaining = k;
        let mut unique_count = frequencies.len() as i32;

        for &freq in frequencies.iter() {
            if k_remaining >= freq {
                k_remaining -= freq;
                unique_count -= 1;
            } else {
                break;
            }
        }

        unique_count
    }
}