use std::collections::HashMap;

impl Solution {
    pub fn intersect(nums1: Vec<i32>, nums2: Vec<i32>) -> Vec<i32> {
        let mut count = HashMap::new();
        for num in nums1 {
            *count.entry(num).or_insert(0) += 1;
        }
        let mut result = Vec::new();
        for num in nums2 {
            if let Some(&c) = count.get(&num) {
                if c > 0 {
                    result.push(num);
                    count.insert(num, c - 1);
                }
            }
        }
        result
    }
}