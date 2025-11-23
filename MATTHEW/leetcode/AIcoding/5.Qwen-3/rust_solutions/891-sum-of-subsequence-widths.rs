impl Solution {

use std::cmp::Ordering;

impl Solution {
    pub fn sum_subseq_widths(mut nums: Vec<i32>) -> i32 {
        nums.sort_unstable();
        let n = nums.len();
        let mod_val = 1_000_000_007;
        let mut pow2 = vec![1; n];
        for i in 1..n {
            pow2[i] = (pow2[i - 1] * 2) % mod_val;
        }
        let mut result = 0;
        for i in 0..n {
            let left = i as i64;
            let right = (n - 1 - i) as i64;
            let contribution = (nums[i] as i64 * (pow2[left] - 1) - nums[i] as i64 * (pow2[right] - 1)) % mod_val;
            result = (result + contribution) % mod_val;
        }
        result as i32
    }
}
}