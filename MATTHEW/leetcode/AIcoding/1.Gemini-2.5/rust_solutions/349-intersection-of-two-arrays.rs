use std::collections::HashSet;

impl Solution {
    pub fn intersection(nums1: Vec<i32>, nums2: Vec<i32>) -> Vec<i32> {
        let mut set1: HashSet<i32> = nums1.into_iter().collect();
        let mut result_set: HashSet<i32> = HashSet::new();

        for num in nums2 {
            if set1.contains(&num) {
                result_set.insert(num);
            }
        }

        result_set.into_iter().collect()
    }
}