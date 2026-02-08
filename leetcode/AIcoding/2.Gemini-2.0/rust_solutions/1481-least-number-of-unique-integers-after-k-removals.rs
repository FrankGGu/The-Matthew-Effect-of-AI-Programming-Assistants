use std::collections::HashMap;

impl Solution {
    pub fn find_least_num_of_unique_integers(arr: Vec<i32>, k: i32) -> i32 {
        let mut counts = HashMap::new();
        for &num in &arr {
            *counts.entry(num).or_insert(0) += 1;
        }

        let mut frequencies: Vec<i32> = counts.values().cloned().collect();
        frequencies.sort();

        let mut removed = 0;
        let mut remaining_k = k;
        for &freq in &frequencies {
            if remaining_k >= freq {
                remaining_k -= freq;
                removed += 1;
            } else {
                break;
            }
        }

        (frequencies.len() as i32) - removed
    }
}