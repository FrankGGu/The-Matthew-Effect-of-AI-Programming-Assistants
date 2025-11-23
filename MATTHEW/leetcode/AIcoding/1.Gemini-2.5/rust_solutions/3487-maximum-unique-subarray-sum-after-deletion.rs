use std::collections::HashSet;

impl Solution {
    pub fn maximum_unique_subarray(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        let mut max_sum = 0;
        let mut current_sum = 0;
        let mut left = 0;
        let mut seen = HashSet::new();

        for right in 0..n {
            while seen.contains(&nums[right]) {
                current_sum -= nums[left];
                seen.remove(&nums[left]);
                left += 1;
            }
            current_sum += nums[right];
            seen.insert(nums[right]);
            max_sum = max_sum.max(current_sum);
        }

        max_sum
    }
}