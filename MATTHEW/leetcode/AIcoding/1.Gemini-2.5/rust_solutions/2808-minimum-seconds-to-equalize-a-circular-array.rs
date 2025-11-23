use std::collections::HashMap;
use std::cmp::{max, min};

impl Solution {
    pub fn minimum_seconds(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        let mut val_indices: HashMap<i32, Vec<usize>> = HashMap::new();

        for (i, &val) in nums.iter().enumerate() {
            val_indices.entry(val).or_default().push(i);
        }

        let mut min_seconds = n as i32; 

        for (_, indices) in val_indices {
            let mut max_dist_for_val = 0;

            // Calculate max distance between consecutive occurrences
            // For example, if indices are [0, 3], the distance is 3-0 = 3.
            // This means there are 2 elements between them that need to be filled.
            for i in 0..indices.len() - 1 {
                max_dist_for_val = max(max_dist_for_val, indices[i+1] - indices[i]);
            }

            // Calculate circular distance
            // This is the distance from the last occurrence back to the first occurrence, wrapping around.
            // Example: n=5, indices=[1, 4]. Last is 4, first is 1.
            // The distance from index 4 to index 1 (circularly) is (n - 4) + 1 = 2.
            // This means elements at index 0 need to be filled.
            max_dist_for_val = max(max_dist_for_val, n - indices.last().unwrap() + indices[0]);

            // The time required for this value to spread is max_dist_for_val / 2 (integer division).
            // We need to find the minimum of these times across all distinct values.
            min_seconds = min(min_seconds, (max_dist_for_val / 2) as i32);
        }

        min_seconds
    }
}