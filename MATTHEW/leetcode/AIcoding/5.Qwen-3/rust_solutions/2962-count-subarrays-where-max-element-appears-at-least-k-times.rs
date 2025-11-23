impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn num_subarrays_with_max_appears_at_least_k_times(nums: Vec<i32>, k: i32) -> i32 {
        let mut count = HashMap::new();
        let mut max_val = nums[0];
        for &num in &nums {
            if num > max_val {
                max_val = num;
            }
        }

        let mut result = 0;
        let mut left = 0;
        let mut freq = 0;

        for right in 0..nums.len() {
            if nums[right] == max_val {
                freq += 1;
            }

            while freq >= k {
                result += nums.len() - right;
                if nums[left] == max_val {
                    freq -= 1;
                }
                left += 1;
            }
        }

        result as i32
    }
}
}