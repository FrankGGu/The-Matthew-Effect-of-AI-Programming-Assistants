impl Solution {

use std::collections::VecDeque;

impl Solution {
    pub fn minimum_sum(nums: Vec<i32>, k: i32, m: i32) -> i32 {
        let n = nums.len();
        let k = k as usize;
        let m = m as usize;

        let mut prefix_sums = vec![0; n + 1];
        for i in 0..n {
            prefix_sums[i + 1] = prefix_sums[i] + nums[i];
        }

        let mut min_sum = i32::MAX;

        for i in 0..=n - k {
            let mut subarrays = Vec::new();
            for j in 0..k {
                let start = i + j;
                let end = start + m;
                if end > n {
                    break;
                }
                let sum = prefix_sums[end] - prefix_sums[start];
                subarrays.push(sum);
            }

            if subarrays.len() == k {
                let total = subarrays.iter().sum::<i32>();
                min_sum = std::cmp::min(min_sum, total);
            }
        }

        min_sum
    }
}
}