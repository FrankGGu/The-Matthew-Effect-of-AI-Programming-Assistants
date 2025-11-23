use std::collections::HashMap;

impl Solution {
    pub fn count_almost_equal_pairs_ii(nums1: Vec<i32>, nums2: Vec<i32>, k: i32) -> i64 {
        let n = nums1.len();
        let mut count = 0;

        let mut nums2_indices: HashMap<i32, Vec<i32>> = HashMap::new();
        for (j, &val) in nums2.iter().enumerate() {
            nums2_indices.entry(val).or_insert_with(Vec::new).push(j as i32);
        }

        for i in 0..n {
            let target_val = nums1[i];
            let current_i = i as i32;

            if let Some(indices) = nums2_indices.get(&target_val) {
                let lower_bound = current_i - k;
                let upper_bound = current_i + k;

                let start_idx = indices.binary_search(&lower_bound).unwrap_or_else(|x| x);
                let end_idx = indices.binary_search(&(upper_bound + 1)).unwrap_or_else(|x| x);

                count += (end_idx - start_idx) as i64;
            }
        }

        count
    }
}