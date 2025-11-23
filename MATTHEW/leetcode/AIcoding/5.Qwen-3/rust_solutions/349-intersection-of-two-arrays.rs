impl Solution {

use std::collections::HashSet;

struct Solution;

impl Solution {
    pub fn intersection(nums1: Vec<i32>, nums2: Vec<i32>) -> Vec<i32> {
        let set1: HashSet<i32> = nums1.into_iter().collect();
        let set2: HashSet<i32> = nums2.into_iter().collect();
        let mut result = Vec::new();
        for num in set1 {
            if set2.contains(&num) {
                result.push(num);
            }
        }
        result
    }
}
}