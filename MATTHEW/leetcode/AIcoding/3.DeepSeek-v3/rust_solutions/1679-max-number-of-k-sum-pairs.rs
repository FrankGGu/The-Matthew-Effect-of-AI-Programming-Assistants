use std::collections::HashMap;

impl Solution {
    pub fn max_operations(nums: Vec<i32>, k: i32) -> i32 {
        let mut freq = HashMap::new();
        let mut count = 0;

        for num in nums {
            let complement = k - num;
            if let Some(val) = freq.get_mut(&complement) {
                if *val > 0 {
                    *val -= 1;
                    count += 1;
                    continue;
                }
            }
            *freq.entry(num).or_insert(0) += 1;
        }

        count
    }
}