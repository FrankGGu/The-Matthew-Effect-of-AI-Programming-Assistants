impl Solution {

use std::cmp::Ordering;

impl Solution {
    pub fn min_div_operations(mut nums: Vec<i32>) -> i32 {
        let mut operations = 0;
        for i in (0..nums.len() - 1).rev() {
            if nums[i] > nums[i + 1] {
                let diff = nums[i] - nums[i + 1];
                let quotient = diff / nums[i + 1];
                if diff % nums[i + 1] != 0 {
                    operations += quotient + 1;
                    nums[i] = nums[i + 1];
                } else {
                    operations += quotient;
                    nums[i] = nums[i + 1];
                }
            }
        }
        operations
    }
}
}