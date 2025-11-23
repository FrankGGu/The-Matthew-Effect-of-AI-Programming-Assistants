impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn maximum_count(nums: Vec<i32>) -> i32 {
        let mut count = HashMap::new();
        for num in nums {
            if num > 0 {
                *count.entry("positive").or_insert(0) += 1;
            } else if num < 0 {
                *count.entry("negative").or_insert(0) += 1;
            }
        }
        let positive = *count.get("positive").unwrap_or(&0);
        let negative = *count.get("negative").unwrap_or(&0);
        positive.max(negative)
    }
}
}