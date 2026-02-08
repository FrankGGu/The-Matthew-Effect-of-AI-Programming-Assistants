use std::collections::HashSet;

impl Solution {
    pub fn find_subarrays(nums: Vec<i32>) -> bool {
        let mut sums = HashSet::new();
        for i in 0..nums.len() - 1 {
            let sum = nums[i] + nums[i + 1];
            if !sums.insert(sum) {
                return true;
            }
        }
        false
    }
}