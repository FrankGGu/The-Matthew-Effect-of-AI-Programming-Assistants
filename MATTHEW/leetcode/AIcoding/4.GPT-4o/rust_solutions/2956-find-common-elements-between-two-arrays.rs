impl Solution {
    pub fn intersection(nums1: Vec<i32>, nums2: Vec<i32>) -> Vec<i32> {
        let set1: std::collections::HashSet<_> = nums1.into_iter().collect();
        let set2: std::collections::HashSet<_> = nums2.into_iter().collect();
        set1.intersection(&set2).cloned().collect()
    }
}