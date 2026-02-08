use std::collections::HashSet;

impl Solution {
    pub fn find_k_distant_indices(nums: Vec<i32>, key: i32, k: i32) -> Vec<i32> {
        let n = nums.len();
        let mut key_indices = Vec::new();
        for (idx, &num) in nums.iter().enumerate() {
            if num == key {
                key_indices.push(idx as i32);
            }
        }

        let mut result_set = HashSet::new();
        for j_val in key_indices {
            let start = (j_val - k).max(0);
            let end = (j_val + k).min((n - 1) as i32);
            for i in start..=end {
                result_set.insert(i);
            }
        }

        let mut result_vec: Vec<i32> = result_set.into_iter().collect();
        result_vec.sort_unstable();
        result_vec
    }
}