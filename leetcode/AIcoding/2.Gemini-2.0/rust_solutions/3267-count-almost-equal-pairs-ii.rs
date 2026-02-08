use std::collections::HashMap;

impl Solution {
    pub fn count_almost_equal_pairs(nums1: Vec<i32>, nums2: Vec<i32>, diff: i32) -> i64 {
        let n = nums1.len();
        let mut count = 0;

        for i in 0..n {
            for j in (i + 1)..n {
                if (nums1[i] - nums1[j]).abs() <= diff && (nums2[i] - nums2[j]).abs() <= diff {
                    count += 1;
                }
            }
        }

        count as i64
    }
}