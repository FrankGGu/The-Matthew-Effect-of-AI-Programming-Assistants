impl Solution {

use std::cmp::Ordering;

struct Solution;

impl Solution {
    pub fn minimum_sum(nums: Vec<i32>, k: i32) -> i32 {
        let k = k as usize;
        let mut nums = nums;
        nums.sort();
        let mut res = 0;
        let mut prev = 0;
        for num in nums {
            if num > prev {
                res += num;
                prev = num;
            }
        }
        res
    }
}
}