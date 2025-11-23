impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn count_almost_equal_pairs(nums: Vec<i32>) -> i32 {
        let mut count = 0;
        let n = nums.len();

        for i in 0..n {
            for j in (i + 1)..n {
                let a = nums[i];
                let b = nums[j];
                let diff = (a - b).abs();
                if diff <= 1 {
                    count += 1;
                }
            }
        }

        count
    }
}
}