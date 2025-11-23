impl Solution {
    pub fn count_subarrays(nums: Vec<i32>, k: i32) -> i64 {
        let n = nums.len();
        let k = k as usize;

        let max_val = *nums.iter().max().unwrap();

        let mut max_val_indices: Vec<usize> = Vec::new();
        for (i, &num) in nums.iter().enumerate() {
            if num == max_val {
                max_val_indices.push(i);
            }
        }

        if max_val_indices.len() < k {
            return 0;
        }

        let mut ans: i64 = 0;

        // Iterate through all possible starting positions of the k-th occurrence of max_val
        // in a valid subarray.
        // `i` represents the 0-indexed position of the first `max_val` in the k-occurrence block.
        // `max_val_indices[i]` is the index of the first `max_val` in the block.
        // `max_val_indices[i + k - 1]` is the index of the k-th `max_val` in the block.
        for i in 0..=max_val_indices.len() - k {
            let current_block_first_max_val_idx = max_val_indices[i];
            let current_block_kth_max_val_idx = max_val_indices[i + k - 1];

            // Calculate the number of possible starting points for a subarray
            // that includes `current_block_first_max_val_idx` as its first `max_val` occurrence
            // and does not include `max_val_indices[i-1]` (if i > 0).
            let num_left_choices: i64;
            if i == 0 {
                // If this is the first block of k occurrences,
                // any starting index from 0 up to `current_block_first_max_val_idx` is valid.
                num_left_choices = (current_block_first_max_val_idx + 1) as i64;
            } else {
                // If `i > 0`, the starting index must be after the previous `max_val` occurrence
                // (i.e., `max_val_indices[i-1]`) and up to `current_block_first_max_val_idx`.
                num_left_choices = (current_block_first_max_val_idx - max_val_indices[i - 1]) as i64;
            }

            // Calculate the number of possible ending points for a subarray
            // that includes `current_block_kth_max_val_idx` as its k-th `max_val` occurrence.
            // Any ending index from `current_block_kth_max_val_idx` up to `n-1` is valid.
            let num_right_choices: i64 = (n - current_block_kth_max_val_idx) as i64;

            ans += num_left_choices * num_right_choices;
        }

        ans
    }
}