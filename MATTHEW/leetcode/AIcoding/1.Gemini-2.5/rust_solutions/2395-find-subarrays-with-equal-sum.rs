use std::collections::HashSet;

impl Solution {
    pub fn find_subarrays(nums: Vec<i32>) -> bool {
        let mut seen_sums: HashSet<i32> = HashSet::new();
        for i in 0..nums.len() - 1 {
            let current_sum = nums[i] + nums[i + 1];
            if seen_sums.contains(&current_sum) {
                return true;
            }
            seen_sums.insert(current_sum);
        }
        false
    }
}