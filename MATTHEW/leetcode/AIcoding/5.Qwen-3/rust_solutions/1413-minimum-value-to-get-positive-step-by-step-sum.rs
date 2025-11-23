impl Solution {

use std::cmp;

impl Solution {
    pub fn min_start_value(nums: Vec<i32>) -> i32 {
        let mut sum = 0;
        let mut min_sum = 0;
        for num in nums {
            sum += num;
            min_sum = cmp::min(min_sum, sum);
        }
        if min_sum >= 0 {
            1
        } else {
            -min_sum + 1
        }
    }
}
}