use std::collections::HashSet;

impl Solution {
    pub fn two_out_of_three(nums1: Vec<i32>, nums2: Vec<i32>, nums3: Vec<i32>) -> Vec<i32> {
        let set1: HashSet<i32> = nums1.into_iter().collect();
        let set2: HashSet<i32> = nums2.into_iter().collect();
        let set3: HashSet<i32> = nums3.into_iter().collect();

        let mut result: HashSet<i32> = HashSet::new();

        for &num in &set1 {
            if set2.contains(&num) || set3.contains(&num) {
                result.insert(num);
            }
        }

        for &num in &set2 {
            if set1.contains(&num) || set3.contains(&num) {
                result.insert(num);
            }
        }

        for &num in &set3 {
            if set1.contains(&num) || set2.contains(&num) {
                result.insert(num);
            }
        }

        result.into_iter().collect()
    }
}