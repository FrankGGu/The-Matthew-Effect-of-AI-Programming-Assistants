use std::collections::HashMap;

impl Solution {
    pub fn most_frequent(nums: Vec<i32>, key: i32) -> i32 {
        let mut counts: HashMap<i32, i32> = HashMap::new();
        for i in 0..nums.len() - 1 {
            if nums[i] == key {
                *counts.entry(nums[i + 1]).or_insert(0) += 1;
            }
        }

        let mut max_count = 0;
        let mut result = 0;
        for (&num, &count) in &counts {
            if count > max_count {
                max_count = count;
                result = num;
            }
        }

        result
    }
}