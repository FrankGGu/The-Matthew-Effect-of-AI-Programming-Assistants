impl Solution {

use std::collections::VecDeque;

impl Solution {
    pub fn maximum_top(nums: Vec<i32>, k: i32) -> i32 {
        let n = nums.len();
        if k == 0 {
            return nums[0];
        }
        if n == 1 {
            return if k % 2 == 0 { nums[0] } else { 0 };
        }
        if k >= (n as i32) {
            return *nums.iter().max().unwrap();
        }
        let mut dq = VecDeque::from(nums);
        for _ in 0..k - 1 {
            dq.pop_front();
        }
        dq.pop_front();
        if dq.is_empty() {
            return 0;
        }
        *dq.iter().max().unwrap()
    }
}
}