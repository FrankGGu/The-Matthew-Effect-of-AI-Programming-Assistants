impl Solution {

use std::collections::HashSet;

impl Solution {
    pub fn number_of_ways(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        let mut left_sum = 0;
        let total_sum: i32 = nums.iter().sum();
        let mut count = 0;

        for i in 0..n - 1 {
            left_sum += nums[i];
            if left_sum * 2 == total_sum - left_sum {
                count += 1;
            }
        }

        count
    }
}
}