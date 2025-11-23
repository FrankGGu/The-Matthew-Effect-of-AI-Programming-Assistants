impl Solution {

use std::cmp::Ordering;

struct Solution {}

impl Solution {
    pub fn find_best_value(mut nums: Vec<i32>, target: i32) -> i32 {
        nums.sort();
        let n = nums.len();
        let mut prefix_sum = vec![0; n];
        prefix_sum[0] = nums[0];
        for i in 1..n {
            prefix_sum[i] = prefix_sum[i - 1] + nums[i];
        }

        let mut left = 0;
        let mut right = nums[n - 1];
        let mut best = 0;
        let mut min_diff = i32::MAX;

        while left <= right {
            let mid = (left + right) / 2;
            let mut sum = 0;
            for i in 0..n {
                if nums[i] < mid {
                    sum += nums[i];
                } else {
                    sum += mid;
                }
            }

            let diff = (sum as i32 - target).abs();
            if diff < min_diff {
                min_diff = diff;
                best = mid;
            }

            match sum.cmp(&target) {
                Ordering::Less => left = mid + 1,
                Ordering::Greater => right = mid - 1,
                Ordering::Equal => return mid,
            }
        }

        best
    }
}
}