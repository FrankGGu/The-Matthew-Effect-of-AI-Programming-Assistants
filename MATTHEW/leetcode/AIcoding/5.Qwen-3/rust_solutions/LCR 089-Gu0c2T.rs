impl Solution {

use std::cmp;

impl Solution {
    pub fn rob(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        if n == 0 {
            return 0;
        }
        if n == 1 {
            return nums[0];
        }
        if n == 2 {
            return cmp::max(nums[0], nums[1]);
        }

        let mut prev_prev = nums[0];
        let mut prev = cmp::max(nums[0], nums[1]);

        for i in 2..n {
            let current = cmp::max(prev, prev_prev + nums[i]);
            prev_prev = prev;
            prev = current;
        }

        prev
    }
}
}