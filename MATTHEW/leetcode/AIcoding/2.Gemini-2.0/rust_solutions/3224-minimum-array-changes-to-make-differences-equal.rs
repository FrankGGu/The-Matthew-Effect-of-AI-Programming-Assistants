use std::collections::HashMap;

impl Solution {
    pub fn min_operations(nums: Vec<i32>, k: i32) -> i32 {
        let n = nums.len();
        let mut counts: HashMap<i32, i32> = HashMap::new();
        for &num in &nums {
            *counts.entry(num % k).or_insert(0) += 1;
        }

        let mut max_count = 0;
        for &count in counts.values() {
            max_count = max_count.max(count);
        }

        (n as i32) - max_count
    }
}