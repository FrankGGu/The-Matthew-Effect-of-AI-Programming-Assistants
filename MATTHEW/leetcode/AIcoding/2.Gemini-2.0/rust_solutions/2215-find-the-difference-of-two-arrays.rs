impl Solution {
    pub fn find_difference(nums1: Vec<i32>, nums2: Vec<i32>) -> Vec<Vec<i32>> {
        use std::collections::HashSet;

        let set1: HashSet<i32> = nums1.iter().cloned().collect();
        let set2: HashSet<i32> = nums2.iter().cloned().collect();

        let diff1: Vec<i32> = set1.difference(&set2).cloned().collect();
        let diff2: Vec<i32> = set2.difference(&set1).cloned().collect();

        vec![diff1, diff2]
    }
}