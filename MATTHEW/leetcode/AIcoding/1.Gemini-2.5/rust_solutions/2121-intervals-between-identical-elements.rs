use std::collections::HashMap;

impl Solution {
    pub fn intervals_between_identical_elements(nums: Vec<i32>) -> Vec<i64> {
        let n = nums.len();
        let mut ans = vec![0; n];
        let mut val_to_indices: HashMap<i32, Vec<i32>> = HashMap::new();

        for (i, &num) in nums.iter().enumerate() {
            val_to_indices.entry(num).or_insert_with(Vec::new).push(i as i32);
        }

        for (_, indices) in val_to_indices {
            let k = indices.len();
            if k <= 1 {
                continue;
            }

            let mut prefix_sums = vec![0i64; k + 1];
            for i in 0..k {
                prefix_sums[i + 1] = prefix_sums[i] + indices[i] as i64;
            }

            for j in 0..k {
                let current_idx = indices[j] as i64;

                // Sum of distances from current_idx to elements on its left
                // (current_idx - indices[0]) + ... + (current_idx - indices[j-1])
                // = j * current_idx - (indices[0] + ... + indices[j-1])
                let count_left = j as i64;
                let sum_left_indices = prefix_sums[j];
                let left_contribution = count_left * current_idx - sum_left_indices;

                // Sum of distances from current_idx to elements on its right
                // (indices[j+1] - current_idx) + ... + (indices[k-1] - current_idx)
                // = (indices[j+1] + ... + indices[k-1]) - (k - 1 - j) * current_idx
                let count_right = (k - 1 - j) as i64;
                let sum_right_indices = prefix_sums[k] - prefix_sums[j + 1];
                let right_contribution = sum_right_indices - count_right * current_idx;

                ans[current_idx as usize] = left_contribution + right_contribution;
            }
        }

        ans
    }
}