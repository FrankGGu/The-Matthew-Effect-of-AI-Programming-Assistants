impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn max_freq(nums: Vec<i32>, k: i32, num_operations: i32, each_operation: i32) -> i32 {
        let mut freq = HashMap::new();
        let mut max_freq = 0;
        let mut left = 0;
        let n = nums.len();

        for right in 0..n {
            *freq.entry(nums[right]).or_insert(0) += 1;
            max_freq = max_freq.max(*freq.get(&nums[right]).unwrap());

            while (right - left + 1) as i32 - max_freq > k {
                *freq.entry(nums[left]).or_insert(0) -= 1;
                if *freq.get(&nums[left]).unwrap() == 0 {
                    freq.remove(&nums[left]);
                }
                left += 1;
            }
        }

        let mut result = 0;
        let mut count = 0;
        let mut current = 0;

        for i in 0..n {
            if i > 0 && nums[i] == nums[i - 1] {
                current += 1;
            } else {
                current = 1;
            }

            if current >= num_operations {
                count += 1;
            }

            if count >= each_operation {
                result = result.max(current);
            }
        }

        result
    }
}
}