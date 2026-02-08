use std::collections::HashSet;
use std::cmp::min;

impl Solution {
    pub fn closest_to_k(arr: Vec<i32>, k: i32) -> i32 {
        let mut min_diff = i32::MAX;
        let mut current_ors: HashSet<i32> = HashSet::new();

        for &num in arr.iter() {
            let mut new_ors: HashSet<i32> = HashSet::new();

            new_ors.insert(num);

            for &prev_or in current_ors.iter() {
                new_ors.insert(prev_or | num);
            }

            current_ors = new_ors;

            for &val in current_ors.iter() {
                min_diff = min(min_diff, (val - k).abs());
            }
        }

        min_diff
    }
}