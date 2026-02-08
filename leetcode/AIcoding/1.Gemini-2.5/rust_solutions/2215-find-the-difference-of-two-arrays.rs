use std::collections::HashSet;

impl Solution {
    pub fn find_difference(nums1: Vec<i32>, nums2: Vec<i32>) -> Vec<Vec<i32>> {
        let set1: HashSet<i32> = nums1.into_iter().collect();
        let set2: HashSet<i32> = nums2.into_iter().collect();

        let mut diff1: Vec<i32> = Vec::new();
        for &num in &set1 {
            if !set2.contains(&num) {
                diff1.push(num);
            }
        }

        let mut diff2: Vec<i32> = Vec::new();
        for &num in &set2 {
            if !set1.contains(&num) {
                diff2.push(num);
            }
        }

        vec![diff1, diff2]
    }
}