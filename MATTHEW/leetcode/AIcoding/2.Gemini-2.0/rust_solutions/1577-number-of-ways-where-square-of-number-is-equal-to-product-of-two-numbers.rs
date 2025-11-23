use std::collections::HashMap;

impl Solution {
    pub fn num_triplets(nums1: Vec<i32>, nums2: Vec<i32>) -> i32 {
        let mut count = 0;
        let mut map1: HashMap<i64, i32> = HashMap::new();
        let mut map2: HashMap<i64, i32> = HashMap::new();

        for &num in &nums1 {
            let square = (num as i64) * (num as i64);
            *map1.entry(square).or_insert(0) += 1;
        }

        for &num in &nums2 {
            let square = (num as i64) * (num as i64);
            *map2.entry(square).or_insert(0) += 1;
        }

        for i in 0..nums1.len() {
            for j in i + 1..nums1.len() {
                let product = (nums1[i] as i64) * (nums1[j] as i64);
                if let Some(&c) = map2.get(&product) {
                    count += c;
                }
            }
        }

        for i in 0..nums2.len() {
            for j in i + 1..nums2.len() {
                let product = (nums2[i] as i64) * (nums2[j] as i64);
                if let Some(&c) = map1.get(&product) {
                    count += c;
                }
            }
        }

        count
    }
}