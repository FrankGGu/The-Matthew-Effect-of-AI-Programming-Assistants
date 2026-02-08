struct Solution;

impl Solution {
    pub fn find_latest_step(arr: Vec<i32>, m: i32) -> i32 {
        let n = arr.len();
        if m as usize > n {
            return -1;
        }

        // `len_at_pos[i]` stores the length of the contiguous block of 1s
        // that position `i` belongs to. This value is only reliable at the
        // endpoints of a block.
        // We use `n + 2` size for 1-indexed positions from 1 to `n`,
        // with padding at index 0 and `n + 1` to simplify boundary checks.
        let mut len_at_pos = vec![0; n + 2];

        // `counts[l]` stores the number of groups of length `l`.
        // Max possible length is `n`.
        let mut counts = vec![0; n + 1];

        let mut latest_step = -1;

        // Iterate through the steps, 1-indexed from 1 to `n`.
        // `step_idx` is 0-indexed, so `step_idx + 1` is the current step number.
        for (step_idx, &pos_val) in arr.iter().enumerate() {
            let pos = pos_val as usize; // The position to turn '1' in this step

            // Determine lengths of adjacent blocks of '1's.
            // `len_at_pos[pos - 1]` gives the length of the block ending at `pos - 1`.
            // `len_at_pos[pos + 1]` gives the length of the block starting at `pos + 1`.
            let left_len = len_at_pos[pos - 1];
            let right_len = len_at_pos[pos + 1];

            // If an adjacent block existed, it will now be merged.
            // So, decrement its count in `counts`.
            if left_len > 0 {
                counts[left_len as usize] -= 1;
            }
            if right_len > 0 {
                counts[right_len as usize] -= 1;
            }

            // Calculate the length of the new merged block.
            let new_len = left_len + 1 + right_len;

            // Increment count for the new block length.
            counts[new_len as usize] += 1;

            // Update `len_at_pos` for the new block's endpoints.
            // The new block starts at `pos - left_len` and ends at `pos + right_len`.
            len_at_pos[pos - left_len as usize] = new_len;
            len_at_pos[pos + right_len as usize] = new_len;
            // Note: `len_at_pos[pos]` itself doesn't need to be updated as it's not an endpoint.

            // Check if there's at least one group of size `m`.
            if counts[m as usize] > 0 {
                latest_step = (step_idx + 1) as i32;
            }
        }

        latest_step
    }
}