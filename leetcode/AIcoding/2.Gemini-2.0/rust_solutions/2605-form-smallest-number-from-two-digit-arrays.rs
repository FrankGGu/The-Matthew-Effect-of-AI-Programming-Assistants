use std::collections::HashSet;

impl Solution {
    pub fn min_number(nums1: Vec<i32>, nums2: Vec<i32>) -> i32 {
        let set1: HashSet<i32> = nums1.iter().cloned().collect();
        let set2: HashSet<i32> = nums2.iter().cloned().collect();

        let intersection: Vec<i32> = set1.intersection(&set2).cloned().collect();

        if !intersection.is_empty() {
            return *intersection.iter().min().unwrap();
        }

        let min1 = *nums1.iter().min().unwrap();
        let min2 = *nums2.iter().min().unwrap();

        if min1 < min2 {
            return min1 * 10 + min2;
        } else {
            return min2 * 10 + min1;
        }
    }
}