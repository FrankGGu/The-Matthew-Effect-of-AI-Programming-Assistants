impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn num_subarrays_with_sum(nums: Vec<i32>, k: i32) -> i32 {
        let mut count = 0;
        let mut prefix_sum = 0;
        let mut sum_counts = HashMap::new();
        sum_counts.insert(0, 1);

        for num in nums {
            prefix_sum += num;
            if let Some(&val) = sum_counts.get(&(prefix_sum - k)) {
                count += val;
            }
            *sum_counts.entry(prefix_sum).or_insert(0) += 1;
        }

        count
    }
}
}