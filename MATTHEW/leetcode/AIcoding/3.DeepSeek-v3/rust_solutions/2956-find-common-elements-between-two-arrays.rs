use std::collections::HashSet;

impl Solution {
    pub fn find_intersection_values(nums1: Vec<i32>, nums2: Vec<i32>) -> Vec<i32> {
        let set1: HashSet<_> = nums1.iter().cloned().collect();
        let set2: HashSet<_> = nums2.iter().cloned().collect();

        let count1 = nums1.iter().filter(|&x| set2.contains(x)).count() as i32;
        let count2 = nums2.iter().filter(|&x| set1.contains(x)).count() as i32;

        vec![count1, count2]
    }
}