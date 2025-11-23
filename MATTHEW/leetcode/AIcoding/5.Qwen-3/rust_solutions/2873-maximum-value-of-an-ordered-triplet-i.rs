impl Solution {

use std::cmp::Ordering;

impl Solution {
    pub fn ordered_triplet(nums: Vec<i32>) -> i32 {
        let mut max_val = 0;
        let n = nums.len();

        for i in 0..n {
            for j in i + 1..n {
                if nums[j] > nums[i] {
                    for k in j + 1..n {
                        if nums[k] > nums[j] {
                            max_val = max_val.max(nums[i] + nums[j] + nums[k]);
                        }
                    }
                }
            }
        }

        max_val
    }
}
}