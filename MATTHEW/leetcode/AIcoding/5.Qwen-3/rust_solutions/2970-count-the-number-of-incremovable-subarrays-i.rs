impl Solution {

use std::cmp;

impl Solution {
    pub fn number_of_subarrays(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        let mut result = 0;

        for i in 0..n {
            let mut current_max = nums[i];
            for j in i..n {
                current_max = cmp::max(current_max, nums[j]);
                if current_max == nums[j] {
                    result += 1;
                }
            }
        }

        result
    }
}
}