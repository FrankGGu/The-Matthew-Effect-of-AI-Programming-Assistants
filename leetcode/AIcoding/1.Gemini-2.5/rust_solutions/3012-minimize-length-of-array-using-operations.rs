use std::collections::HashMap;

impl Solution {
    pub fn min_length(nums: Vec<i32>) -> i32 {
        let mut counts: HashMap<i32, i32> = HashMap::new();

        for num in nums {
            *counts.entry(num).or_insert(0) += 1;
        }

        let mut remaining_elements = 0;
        for count in counts.values() {
            if count % 2 != 0 {
                remaining_elements += 1;
            }
        }

        remaining_elements
    }
}