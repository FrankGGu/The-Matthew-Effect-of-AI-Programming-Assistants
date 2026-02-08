use std::collections::BTreeSet;

impl Solution {
    pub fn lex_smallest_array(nums: Vec<i32>, limit: i32) -> Vec<i32> {
        let n = nums.len();
        let mut sorted_indices: Vec<usize> = (0..n).collect();
        sorted_indices.sort_by_key(|&i| nums[i]);

        let mut res = vec![0; n];
        let mut groups = Vec::new();
        let mut current_group = Vec::new();

        for i in 0..n {
            if !current_group.is_empty() && nums[sorted_indices[i]] - nums[sorted_indices[i - 1]] > limit {
                groups.push(current_group);
                current_group = Vec::new();
            }
            current_group.push(sorted_indices[i]);
        }
        if !current_group.is_empty() {
            groups.push(current_group);
        }

        for group in groups {
            let mut sorted_group = group.clone();
            sorted_group.sort();
            let mut values: Vec<i32> = group.iter().map(|&i| nums[i]).collect();
            values.sort();
            for (idx, &original_idx) in sorted_group.iter().enumerate() {
                res[original_idx] = values[idx];
            }
        }

        res
    }
}