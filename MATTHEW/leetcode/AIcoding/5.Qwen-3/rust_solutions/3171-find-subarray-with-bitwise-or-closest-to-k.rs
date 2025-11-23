impl Solution {

use std::cmp::Ordering;

impl Solution {
    pub fn closest_to_k(nums: Vec<i32>, k: i32) -> i32 {
        let n = nums.len();
        let mut min_diff = i32::MAX;
        let mut result = 0;

        for i in 0..n {
            let mut current_or = 0;
            for j in i..n {
                current_or |= nums[j];
                let diff = (current_or - k).abs();
                if diff < min_diff {
                    min_diff = diff;
                    result = current_or;
                }
                if min_diff == 0 {
                    return result;
                }
            }
        }

        result
    }
}
}