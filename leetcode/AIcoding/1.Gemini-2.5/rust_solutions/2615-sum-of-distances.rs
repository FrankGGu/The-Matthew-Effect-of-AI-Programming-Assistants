use std::collections::HashMap;

impl Solution {
    pub fn sum_distances(nums: Vec<i32>) -> Vec<i64> {
        let n = nums.len();
        let mut result = vec![0; n];
        let mut val_to_indices: HashMap<i32, Vec<i32>> = HashMap::new();

        for (i, &num) in nums.iter().enumerate() {
            val_to_indices.entry(num).or_insert_with(Vec::new).push(i as i32);
        }

        for (_, indices) in val_to_indices {
            if indices.len() <= 1 {
                continue;
            }

            let total_sum_of_indices: i64 = indices.iter().map(|&x| x as i64).sum();
            let mut prefix_sum_indices: i64 = 0;

            for p in 0..indices.len() {
                let current_idx = indices[p] as i64;
                let left_count = p as i64;
                let right_count = (indices.len() - 1 - p) as i64;

                let sum_left_distances = left_count * current_idx - prefix_sum_indices;

                prefix_sum_indices += current_idx; 

                let sum_right_distances = (total_sum_of_indices - prefix_sum_indices) - right_count * current_idx;

                result[current_idx as usize] = sum_left_distances + sum_right_distances;
            }
        }

        result
    }
}