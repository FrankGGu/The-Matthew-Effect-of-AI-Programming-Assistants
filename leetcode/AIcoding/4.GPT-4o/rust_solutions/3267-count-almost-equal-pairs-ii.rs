use std::collections::HashMap;

impl Solution {
    pub fn count_almost_equal_pairs(nums1: Vec<i32>, nums2: Vec<i32>) -> i32 {
        let mut count = 0;
        let mut freq = HashMap::new();

        for &num in &nums1 {
            *freq.entry(num).or_insert(0) += 1;
        }

        for &num in &nums2 {
            for i in -1..=1 {
                if let Some(&c) = freq.get(&(num + i)) {
                    count += c;
                }
            }
        }

        count
    }
}