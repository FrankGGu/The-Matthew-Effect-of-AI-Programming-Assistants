use std::collections::HashSet;

impl Solution {
    pub fn distinct_averages(nums: Vec<i32>) -> i32 {
        let mut nums = nums;
        nums.sort_unstable();
        let mut set = HashSet::new();
        let mut left = 0;
        let mut right = nums.len() - 1;
        while left < right {
            let avg = (nums[left] + nums[right]) as f64 / 2.0;
            set.insert(avg.to_bits());
            left += 1;
            right -= 1;
        }
        set.len() as i32
    }
}