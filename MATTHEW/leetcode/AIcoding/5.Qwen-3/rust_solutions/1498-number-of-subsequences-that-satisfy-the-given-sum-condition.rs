impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn num_subseqs_that_sum_up_to_target(nums: Vec<i32>, target: i32) -> i32 {
        let mut nums = nums;
        nums.sort();
        let n = nums.len();
        let mut count = 0;
        let mod_val = 1_000_000_007;

        let mut prefix = vec![0; n];
        prefix[0] = nums[0];
        for i in 1..n {
            prefix[i] = prefix[i - 1] + nums[i];
        }

        for i in 0..n {
            let mut left = i;
            let mut right = n - 1;
            let mut res = -1;
            while left <= right {
                let mid = left + (right - left) / 2;
                if prefix[mid] - prefix[i] + nums[i] <= target {
                    res = mid as i32;
                    left = mid + 1;
                } else {
                    right = mid - 1;
                }
            }
            if res != -1 {
                let k = res - i as i32;
                count = (count + (1 << k) - 1) % mod_val;
            }
        }

        count
    }
}
}