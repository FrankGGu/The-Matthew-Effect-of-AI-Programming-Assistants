impl Solution {

use std::cmp;

impl Solution {
    pub fn min_array_sum(nums: Vec<i32>, k: i32, x: i32) -> i32 {
        let k = k as usize;
        let x = x as usize;
        let n = nums.len();

        let mut nums = nums;
        for i in 0..k {
            let idx = i % n;
            let val = nums[idx];
            if val < 1 {
                nums[idx] += 1;
            } else {
                break;
            }
        }

        nums.iter().sum()
    }
}

struct Solution;
}