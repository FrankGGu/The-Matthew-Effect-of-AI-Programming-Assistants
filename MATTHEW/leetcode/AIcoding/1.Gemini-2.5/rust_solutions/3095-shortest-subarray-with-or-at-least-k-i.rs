impl Solution {
    pub fn shortest_subarray_with_or_at_least_k(nums: Vec<i32>, k: i32) -> i32 {
        let n = nums.len();
        let mut min_len: Option<i32> = None;

        // current_ors stores (OR_value, start_index) pairs for all unique OR values
        // of subarrays ending at the previous index (r-1).
        // For each unique OR_value, it stores the smallest start_index found.
        // The list is effectively sorted by OR_value.
        let mut current_ors: Vec<(i32, usize)> = Vec::new();

        for r in 0..n {
            let num_r = nums[r];
            let mut temp_ors: Vec<(i32, usize)> = Vec::new();

            // The current number itself forms a subarray ending at r
            temp_ors.push((num_r, r));

            // Extend all previous subarrays by ORing with num_r
            for &(val, idx) in current_ors.iter() {
                temp_ors.push((val | num_r, idx));
            }

            // Sort temp_ors to group identical OR_values together.
            // If OR_values are equal, sort by start_index to easily pick the smallest.
            temp_ors.sort_unstable_by(|a, b| {
                if a.0 != b.0 {
                    a.0.cmp(&b.0)
                } else {
                    a.1.cmp(&b.1)
                }
            });

            // Filter temp_ors to keep only unique OR_values,
            // and for each unique OR_value, its smallest start_index.
            current_ors.clear();
            if !temp_ors.is_empty() {
                current_ors.push(temp_ors[0]);
                for i in 1..temp_ors.len() {
                    // If the current OR_value is different from the last one added, add it.
                    // Due to sorting, this ensures we keep the first occurrence of each OR_value,
                    // which corresponds to the smallest start_index for that OR_value.
                    if temp_ors[i].0 != current_ors.last().unwrap().0 {
                        current_ors.push(temp_ors[i]);
                    }
                }
            }

            // Check the current set of unique OR_values for subarrays that satisfy the condition
            for &(val, idx) in current_ors.iter() {
                if val >= k {
                    let current_length = (r - idx + 1) as i32;
                    min_len = match min_len {
                        Some(prev_min) => Some(prev_min.min(current_length)),
                        None => Some(current_length),
                    };
                }
            }
        }

        min_len.unwrap_or(-1)
    }
}