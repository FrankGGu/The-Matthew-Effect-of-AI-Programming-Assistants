impl Solution {

use std::collections::HashSet;

impl Solution {
    pub fn find_subarrays_with_equal_sum(nums: Vec<i32>) -> bool {
        let n = nums.len();
        let mut seen = HashSet::new();

        for i in 0..n - 1 {
            let sum = nums[i] + nums[i + 1];
            if seen.contains(&sum) {
                return true;
            }
            seen.insert(sum);
        }

        false
    }
}
}