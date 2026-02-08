use std::collections::HashMap;

impl Solution {
    pub fn four_sum_count(nums1: Vec<i32>, nums2: Vec<i32>, nums3: Vec<i32>, nums4: Vec<i32>) -> i32 {
        let mut map_ab: HashMap<i32, i32> = HashMap::new();

        for &n1 in nums1.iter() {
            for &n2 in nums2.iter() {
                *map_ab.entry(n1 + n2).or_insert(0) += 1;
            }
        }

        let mut count = 0;
        for &n3 in nums3.iter() {
            for &n4 in nums4.iter() {
                let target = -(n3 + n4);
                if let Some(&freq) = map_ab.get(&target) {
                    count += freq;
                }
            }
        }

        count
    }
}