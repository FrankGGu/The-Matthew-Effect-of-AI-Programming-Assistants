use std::collections::HashMap;

impl Solution {
    pub fn min_operations(nums: Vec<i32>, k: i32) -> i32 {
        let n = nums.len();
        let mut freq = HashMap::new();

        for i in 0..n {
            let target = nums[i] - k;
            *freq.entry(target).or_insert(0) += 1;
        }

        let mut min_ops = n as i32;

        for &count in freq.values() {
            min_ops = min_ops.min(n as i32 - count);
        }

        min_ops
    }
}