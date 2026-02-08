use std::collections::HashSet;

impl Solution {
    pub fn find_subarrays(nums: Vec<i32>) -> bool {
        let mut seen = HashSet::new();
        for i in 0..nums.len() - 1 {
            let sum = nums[i] + nums[i + 1];
            if seen.contains(&sum) {
                return true;
            }
            seen.insert(sum);
        }
        false
    }
}