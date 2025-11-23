impl Solution {

use std::cmp;

impl Solution {
    pub fn maximum_difference(nums: Vec<i32>) -> i32 {
        let mut min_val = nums[0];
        let mut max_diff = 0;

        for &num in &nums[1..] {
            if num > min_val {
                max_diff = cmp::max(max_diff, num - min_val);
            } else {
                min_val = num;
            }
        }

        max_diff
    }
}
}