impl Solution {

use std::cmp::Ordering;

impl Solution {
    pub fn minimum_difference(nums: Vec<i32>, k: i32) -> i32 {
        let k = k as usize;
        let mut nums = nums;
        nums.sort();
        let mut min_diff = i32::MAX;
        for i in 0..nums.len() - k + 1 {
            let diff = nums[i + k - 1] - nums[i];
            if diff < min_diff {
                min_diff = diff;
            }
        }
        min_diff
    }
}
}