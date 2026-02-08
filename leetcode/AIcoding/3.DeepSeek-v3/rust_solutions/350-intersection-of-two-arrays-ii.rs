use std::collections::HashMap;

impl Solution {
    pub fn intersect(nums1: Vec<i32>, nums2: Vec<i32>) -> Vec<i32> {
        let mut freq = HashMap::new();
        for num in nums1 {
            *freq.entry(num).or_insert(0) += 1;
        }

        let mut result = Vec::new();
        for num in nums2 {
            if let Some(count) = freq.get_mut(&num) {
                if *count > 0 {
                    result.push(num);
                    *count -= 1;
                }
            }
        }

        result
    }
}