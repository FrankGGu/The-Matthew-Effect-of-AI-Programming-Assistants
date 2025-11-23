impl Solution {

use std::cmp::Ordering;

impl Solution {
    pub fn predict_the_winner(nums: Vec<i32>) -> bool {
        fn helper(nums: &[i32], start: usize, end: usize) -> i32 {
            if start == end {
                return nums[start];
            }
            let pick_left = nums[start] - helper(nums, start + 1, end);
            let pick_right = nums[end] - helper(nums, start, end - 1);
            std::cmp::max(pick_left, pick_right)
        }
        helper(&nums, 0, nums.len() - 1) >= 0
    }
}
}