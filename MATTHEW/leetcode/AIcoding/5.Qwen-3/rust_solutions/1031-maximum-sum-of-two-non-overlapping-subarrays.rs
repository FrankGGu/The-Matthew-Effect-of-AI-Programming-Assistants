impl Solution {

use std::cmp::max;

impl Solution {
    pub fn max_sum_two_subarrays(nums: Vec<i32>, k: i32) -> i32 {
        let n = nums.len();
        let k = k as usize;
        let mut left = vec![0; n];
        let mut right = vec![0; n];
        let mut curr = 0;
        for i in 0..n {
            curr += nums[i];
            if i >= k {
                curr -= nums[i - k];
            }
            if i >= k - 1 {
                left[i] = curr;
            } else {
                left[i] = i32::MIN;
            }
        }
        curr = 0;
        for i in (0..n).rev() {
            curr += nums[i];
            if i + k < n {
                curr -= nums[i + k];
            }
            if i + k <= n {
                right[i] = curr;
            } else {
                right[i] = i32::MIN;
            }
        }
        let mut res = i32::MIN;
        for i in 0..n {
            if i >= k {
                res = max(res, left[i] + right[i - k]);
            }
            if i + k < n {
                res = max(res, right[i] + left[i + k]);
            }
        }
        res
    }
}
}