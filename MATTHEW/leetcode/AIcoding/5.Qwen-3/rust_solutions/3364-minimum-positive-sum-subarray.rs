impl Solution {

use std::cmp;

impl Solution {
    pub fn minimum_positive_sum_subarray(nums: Vec<i32>) -> i32 {
        let mut min_sum = i32::MAX;
        let mut current_sum = 0;

        for num in nums {
            current_sum += num;
            if current_sum > 0 {
                min_sum = cmp::min(min_sum, current_sum);
            } else {
                current_sum = 0;
            }
        }

        min_sum
    }
}
}