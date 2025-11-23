impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn find_good_indices(nums: Vec<i32>, k: i32) -> Vec<i32> {
        let n = nums.len();
        let k = k as usize;
        let mut left = vec![0; n];
        let mut right = vec![0; n];

        for i in 1..n {
            if nums[i] <= nums[i - 1] {
                left[i] = left[i - 1] + 1;
            }
        }

        for i in (0..n - 1).rev() {
            if nums[i] <= nums[i + 1] {
                right[i] = right[i + 1] + 1;
            }
        }

        let mut result = Vec::new();
        for i in 0..n {
            if left[i] >= k && right[i] >= k {
                result.push(i as i32);
            }
        }

        result
    }
}
}