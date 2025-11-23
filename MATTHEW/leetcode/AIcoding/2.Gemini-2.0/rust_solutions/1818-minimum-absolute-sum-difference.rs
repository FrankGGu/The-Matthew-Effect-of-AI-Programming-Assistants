use std::cmp::Ordering;

impl Solution {
    pub fn min_absolute_sum_difference(nums1: Vec<i32>, nums2: Vec<i32>) -> i32 {
        let n = nums1.len();
        let mut sorted_nums1 = nums1.clone();
        sorted_nums1.sort();
        let mut sum: i64 = 0;
        for i in 0..n {
            sum += (nums1[i] - nums2[i]).abs() as i64;
        }

        let mut max_diff: i64 = 0;
        for i in 0..n {
            let diff = (nums1[i] - nums2[i]).abs() as i64;
            let target = nums2[i];
            let pos = sorted_nums1.binary_search(&target);
            match pos {
                Ok(_) => {
                    if diff > 0 {
                        max_diff = max_diff.max(diff);
                    }
                }
                Err(pos) => {
                    if pos < n {
                        max_diff = max_diff.max(diff - (sorted_nums1[pos] - target).abs() as i64);
                    }
                    if pos > 0 {
                        max_diff = max_diff.max(diff - (sorted_nums1[pos - 1] - target).abs() as i64);
                    }
                }
            }
        }

        ((sum - max_diff) % 1000000007) as i32
    }
}