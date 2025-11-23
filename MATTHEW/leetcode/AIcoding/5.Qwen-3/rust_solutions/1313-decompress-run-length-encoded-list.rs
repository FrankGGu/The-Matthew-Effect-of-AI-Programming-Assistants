impl Solution {

use std::vec;

impl Solution {
    pub fn decompress_rl_elist(nums: Vec<i32>) -> Vec<i32> {
        let mut result = vec![];
        for i in (0..nums.len()).step_by(2) {
            let count = nums[i] as usize;
            let val = nums[i + 1];
            for _ in 0..count {
                result.push(val);
            }
        }
        result
    }
}
}