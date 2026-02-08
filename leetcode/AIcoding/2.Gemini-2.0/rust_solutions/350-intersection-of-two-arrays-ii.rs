use std::collections::HashMap;

impl Solution {
    pub fn intersect(nums1: Vec<i32>, nums2: Vec<i32>) -> Vec<i32> {
        let mut counts1: HashMap<i32, i32> = HashMap::new();
        for &num in &nums1 {
            *counts1.entry(num).or_insert(0) += 1;
        }

        let mut result: Vec<i32> = Vec::new();
        for &num in &nums2 {
            if let Some(count) = counts1.get_mut(&num) {
                if *count > 0 {
                    result.push(num);
                    *count -= 1;
                }
            }
        }

        result
    }
}