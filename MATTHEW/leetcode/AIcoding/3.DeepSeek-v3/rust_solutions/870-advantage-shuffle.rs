use std::collections::BTreeMap;

impl Solution {
    pub fn advantage_count(nums1: Vec<i32>, nums2: Vec<i32>) -> Vec<i32> {
        let n = nums1.len();
        let mut nums1_sorted = nums1.clone();
        nums1_sorted.sort_unstable();

        let mut nums2_with_index: Vec<(i32, usize)> = nums2.iter().enumerate().map(|(i, &num)| (num, i)).collect();
        nums2_with_index.sort_unstable();

        let mut res = vec![0; n];
        let mut left = 0;
        let mut right = n - 1;

        for &num in nums1_sorted.iter().rev() {
            if num > nums2_with_index[right].0 {
                res[nums2_with_index[right].1] = num;
                right -= 1;
            } else {
                res[nums2_with_index[left].1] = num;
                left += 1;
            }
        }

        res
    }
}