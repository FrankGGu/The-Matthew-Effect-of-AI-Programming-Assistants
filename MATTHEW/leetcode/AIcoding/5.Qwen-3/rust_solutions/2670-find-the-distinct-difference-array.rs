impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn distinct_difference_array(nums: Vec<i32>) -> Vec<i32> {
        let mut left_counts = HashMap::new();
        let mut right_counts = HashMap::new();
        let mut result = Vec::new();

        for &num in &nums {
            *right_counts.entry(num).or_insert(0) += 1;
        }

        for &num in &nums {
            *left_counts.entry(num).or_insert(0) += 1;
            *right_counts.entry(num).or_insert(0) -= 1;
            if right_counts[&num] == 0 {
                right_counts.remove(&num);
            }

            let left_unique = left_counts.len() as i32;
            let right_unique = right_counts.len() as i32;
            result.push(left_unique - right_unique);
        }

        result
    }
}
}