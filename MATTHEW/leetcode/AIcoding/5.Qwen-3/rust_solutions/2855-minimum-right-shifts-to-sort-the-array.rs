impl Solution {

use std::cmp::Ordering;

impl Solution {
    pub fn minimum_right_shifts(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        if n == 1 {
            return 0;
        }

        let mut pos = 0;
        for i in 1..n {
            if nums[i] < nums[i - 1] {
                pos = i;
                break;
            }
        }

        for i in pos..n {
            if nums[i] > nums[(i + 1) % n] {
                return -1;
            }
        }

        if pos == 0 {
            0
        } else {
            (n - pos) as i32
        }
    }
}
}