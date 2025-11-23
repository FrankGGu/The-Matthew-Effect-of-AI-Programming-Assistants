impl Solution {

use std::collections::HashSet;

impl Solution {
    pub fn subset_xor_sum(nums: Vec<i32>) -> i32 {
        let mut result = 0;
        let n = nums.len();
        for mask in 0..(1 << n) {
            let mut xor_val = 0;
            for i in 0..n {
                if (mask >> i) & 1 == 1 {
                    xor_val ^= nums[i];
                }
            }
            result += xor_val;
        }
        result
    }
}
}