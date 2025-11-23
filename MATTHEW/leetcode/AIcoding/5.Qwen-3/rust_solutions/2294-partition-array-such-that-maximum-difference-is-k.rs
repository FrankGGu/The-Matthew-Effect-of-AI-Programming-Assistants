impl Solution {

use std::cmp::Ordering;

impl Solution {
    pub fn is_possible_to_partition(nums: Vec<i32>, k: i32) -> bool {
        let mut nums = nums;
        nums.sort();
        let n = nums.len();

        for i in 0..n {
            if i > 0 && nums[i] - nums[i - 1] > k {
                return false;
            }
        }

        true
    }
}
}