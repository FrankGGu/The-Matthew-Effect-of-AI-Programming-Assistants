use std::collections::HashMap;

impl Solution {
    pub fn find_least_num_of_unique_ints(arr: Vec<i32>, k: i32) -> i32 {
        let mut counts: HashMap<i32, i32> = HashMap::new();
        for &x in &arr {
            *counts.entry(x).or_insert(0) += 1;
        }

        let mut freq: Vec<i32> = counts.values().cloned().collect();
        freq.sort();

        let mut k_mut = k;
        let mut removed = 0;
        for &f in &freq {
            if k_mut >= f {
                k_mut -= f;
                removed += 1;
            } else {
                break;
            }
        }

        (freq.len() as i32) - removed
    }
}