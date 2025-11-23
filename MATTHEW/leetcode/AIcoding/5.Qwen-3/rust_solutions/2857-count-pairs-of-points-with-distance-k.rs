impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn number_of_pairs(nums1: Vec<i32>, nums2: Vec<i32>, k: i32) -> i32 {
        let mut map = HashMap::new();
        let mut count = 0;
        for i in 0..nums1.len() {
            let diff = nums1[i] - nums2[i];
            let target = diff - k;
            if let Some(&v) = map.get(&target) {
                count += v;
            }
            *map.entry(diff).or_insert(0) += 1;
        }
        count
    }
}
}