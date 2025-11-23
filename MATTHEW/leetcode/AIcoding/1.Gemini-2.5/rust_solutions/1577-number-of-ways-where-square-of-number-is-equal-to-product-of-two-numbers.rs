use std::collections::HashMap;

impl Solution {
    pub fn num_triplets(nums1: Vec<i32>, nums2: Vec<i32>) -> i32 {
        let mut total_triplets: i64 = 0;

        // Type 1: nums1[i]^2 = nums2[j] * nums2[k] where 0 <= i < nums1.length and 0 <= j < k < nums2.length
        // Step 1: Pre-calculate products of pairs from nums2 and store their counts.
        let mut products2_map: HashMap<i64, i64> = HashMap::new();
        for j in 0..nums2.len() {
            for k in (j + 1)..nums2.len() {
                let prod = nums2[j] as i64 * nums2[k] as i64;
                *products2_map.entry(prod).or_insert(0) += 1;
            }
        }

        // Step 2: Iterate through nums1, calculate square, and look up in products2_map.
        for i in 0..nums1.len() {
            let target = nums1[i] as i64 * nums1[i] as i64;
            if let Some(&count) = products2_map.get(&target) {
                total_triplets += count;
            }
        }

        // Type 2: nums2[i]^2 = nums1[j] * nums1[k] where 0 <= i < nums2.length and 0 <= j < k < nums1.length
        // Step 1: Pre-calculate products of pairs from nums1 and store their counts.
        let mut products1_map: HashMap<i64, i64> = HashMap::new();
        for j in 0..nums1.len() {
            for k in (j + 1)..nums1.len() {
                let prod = nums1[j] as i64 * nums1[k] as i64;
                *products1_map.entry(prod).or_insert(0) += 1;
            }
        }

        // Step 2: Iterate through nums2, calculate square, and look up in products1_map.
        for i in 0..nums2.len() {
            let target = nums2[i] as i64 * nums2[i] as i64;
            if let Some(&count) = products1_map.get(&target) {
                total_triplets += count;
            }
        }

        total_triplets as i32
    }
}