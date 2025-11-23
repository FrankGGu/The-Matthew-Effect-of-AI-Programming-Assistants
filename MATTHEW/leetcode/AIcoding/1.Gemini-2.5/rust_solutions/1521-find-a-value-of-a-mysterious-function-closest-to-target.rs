use std::collections::HashSet;

impl Solution {
    pub fn closest_to_target(arr: Vec<i32>, target: i32) -> i32 {
        let n = arr.len();
        let mut min_diff = i32::MAX;

        let mut current_and_values: HashSet<i32> = HashSet::new();

        for r in 0..n {
            let mut new_and_values: HashSet<i32> = HashSet::new();

            new_and_values.insert(arr[r]);

            for &val in &current_and_values {
                new_and_values.insert(val & arr[r]);
            }

            for &val in &new_and_values {
                min_diff = min_diff.min((val - target).abs());
            }

            current_and_values = new_and_values;
        }

        min_diff
    }
}