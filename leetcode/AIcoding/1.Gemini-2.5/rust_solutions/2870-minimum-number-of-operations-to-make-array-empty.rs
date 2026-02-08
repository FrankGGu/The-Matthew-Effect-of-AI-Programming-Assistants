use std::collections::HashMap;

impl Solution {
    pub fn min_operations(nums: Vec<i32>) -> i32 {
        let mut counts: HashMap<i32, i32> = HashMap::new();
        for num in nums {
            *counts.entry(num).or_insert(0) += 1;
        }

        let mut total_operations = 0;
        for (&_num, &count) in counts.iter() {
            if count == 1 {
                return -1;
            }
            total_operations += (count + 2) / 3;
        }

        total_operations
    }
}