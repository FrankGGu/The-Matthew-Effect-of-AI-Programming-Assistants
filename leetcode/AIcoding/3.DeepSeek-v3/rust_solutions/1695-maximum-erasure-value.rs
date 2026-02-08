use std::collections::HashSet;

impl Solution {
    pub fn maximum_unique_subarray(nums: Vec<i32>) -> i32 {
        let mut set = HashSet::new();
        let mut max_sum = 0;
        let mut current_sum = 0;
        let mut left = 0;

        for right in 0..nums.len() {
            while set.contains(&nums[right]) {
                set.remove(&nums[left]);
                current_sum -= nums[left];
                left += 1;
            }
            set.insert(nums[right]);
            current_sum += nums[right];
            max_sum = max_sum.max(current_sum);
        }

        max_sum
    }
}