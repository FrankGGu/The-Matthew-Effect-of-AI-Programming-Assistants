impl Solution {

use std::collections::HashSet;

impl Solution {
    pub fn common_prefix(nums1: Vec<i32>, nums2: Vec<i32>) -> Vec<i32> {
        let n = nums1.len();
        let mut set1 = HashSet::new();
        let mut set2 = HashSet::new();
        let mut result = Vec::with_capacity(n);

        for i in 0..n {
            set1.insert(nums1[i]);
            set2.insert(nums2[i]);
            let common: HashSet<_> = set1.intersection(&set2).collect();
            result.push(common.len() as i32);
        }

        result
    }
}
}