impl Solution {

use std::cmp;

impl Solution {
    pub fn maximum_score(nums: Vec<i32>, k: i32) -> i32 {
        let n = nums.len();
        let mut left = k as usize;
        let mut right = k as usize;
        let mut min_val = nums[k as usize];
        let mut max_score = min_val;

        while left > 0 || right < n - 1 {
            if left == 0 {
                right += 1;
            } else if right == n - 1 {
                left -= 1;
            } else if nums[left - 1] > nums[right + 1] {
                left -= 1;
            } else {
                right += 1;
            }

            min_val = cmp::min(min_val, nums[left], nums[right]);
            max_score = cmp::max(max_score, min_val * (right as i32 - left as i32 + 1));
        }

        max_score
    }
}
}