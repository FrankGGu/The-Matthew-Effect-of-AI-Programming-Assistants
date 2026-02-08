use std::collections::HashSet;

impl Solution {
    pub fn maximum_set_size(nums1: Vec<i32>, nums2: Vec<i32>) -> i32 {
        let n = nums1.len();
        let set1: HashSet<_> = nums1.into_iter().collect();
        let set2: HashSet<_> = nums2.into_iter().collect();

        let common: HashSet<_> = set1.intersection(&set2).cloned().collect();
        let c = common.len();
        let a = set1.len() - c;
        let b = set2.len() - c;

        let max_a = std::cmp::min(a, n / 2);
        let max_b = std::cmp::min(b, n / 2);

        if max_a + max_b + c >= n {
            n as i32
        } else {
            (max_a + max_b + c) as i32
        }
    }
}