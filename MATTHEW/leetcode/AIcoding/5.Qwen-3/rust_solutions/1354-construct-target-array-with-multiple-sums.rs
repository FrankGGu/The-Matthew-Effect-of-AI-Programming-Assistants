impl Solution {

use std::collections::HashSet;

impl Solution {
    pub fn target_array_insert_position(nums: Vec<i32>, target: i32) -> i32 {
        let mut left = 0;
        let mut right = nums.len() as i32 - 1;

        while left <= right {
            let mid = (left + right) / 2;
            if nums[mid as usize] < target {
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }

        left
    }
}
}