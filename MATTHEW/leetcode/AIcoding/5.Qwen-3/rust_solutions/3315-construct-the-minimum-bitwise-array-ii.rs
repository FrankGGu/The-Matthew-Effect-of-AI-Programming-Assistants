impl Solution {

use std::collections::VecDeque;

impl Solution {
    pub fn min_bitwise_array(nums: Vec<i32>) -> Vec<i32> {
        let n = nums.len();
        let mut result = vec![0; n];
        let mut dq = VecDeque::new();

        for i in 0..n {
            while let Some(&j) = dq.back() {
                if nums[j] & nums[i] == nums[j] {
                    dq.pop_back();
                } else {
                    break;
                }
            }

            if dq.is_empty() {
                result[i] = nums[i];
            } else {
                result[i] = nums[dq.back().unwrap()] & nums[i];
            }

            dq.push_back(i);
        }

        result
    }
}
}