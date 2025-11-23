impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn added_integer(nums1: Vec<i32>, nums2: Vec<i32>) -> i32 {
        let mut count = HashMap::new();
        for &num in &nums2 {
            *count.entry(num).or_insert(0) += 1;
        }
        for &num in &nums1 {
            *count.entry(num).or_insert(0) -= 1;
        }
        for (key, &val) in count.iter() {
            if val != 0 {
                return *key - nums1[0];
            }
        }
        0
    }
}
}