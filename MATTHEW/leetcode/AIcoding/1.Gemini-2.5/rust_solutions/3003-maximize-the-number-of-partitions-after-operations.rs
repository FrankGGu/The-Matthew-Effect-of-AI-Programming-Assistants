impl Solution {
    pub fn max_partitions_after_operations(s: String) -> i32 {
        let n = s.len();
        let chars: Vec<char> = s.chars().collect();

        let mut dp_no_op = vec![0; n + 1];
        let mut dp_with_op = vec![0; n + 1];

        let mut last_seen_no_op: [i32; 26] = [-1; 26];
        let mut current_start_no_op: i32 = 0;

        let mut last_seen_with_op: [i32; 26] = [-1; 26];
        let mut current_start_with_op: i32 = 0;

        for i in 0..n {
            let char_val = (chars[i] as u8 - b'a') as usize;

            // Calculate dp_no_op[i+1]
            let prev_current_start_no_op = current_start_no_op; // Store for dp_with_op option B
            current_start_no_op = current_start_no_op.max(last_seen_no_op[char_val] + 1);
            dp_no_op[i + 1] = dp_no_op[current_start_no_op as usize] + 1;
            last_seen_no_op[char_val] = i as i32;

            // Calculate dp_with_op[i+1]
            // Option A: Operation used before index `i`. `s[i]` is processed normally.
            let current_start_op_A = current_start_with_op.max(last_seen_with_op[char_val] + 1);
            let val_A = dp_with_op[current_start_op_A as usize] + 1;
            let mut last_seen_op_A = last_seen_with_op; // Copy current state
            last_seen_op_A[char_val] = i as i32;

            // Option B: Operation is used *at* index `i`.
            //           `s[i]` is changed, so it doesn't cause a break.
            //           Partitions up to `i-1` were counted without operation (`dp_no_op` values).
            //           The current partition starts at `prev_current_start_no_op`.
            let val_B = dp_no_op[prev_current_start_no_op as usize] + 1;
            let current_start_op_B = prev_current_start_no_op;
            let mut last_seen_op_B = [-1; 26]; // This should be the `last_seen_no_op` state *before* `s[i]` was processed.
                                              // We need a copy of `last_seen_no_op` from the state that led to `dp_no_op[prev_current_start_no_op]`.
                                              // This is tricky. The `last_seen_no_op` array itself changes.
                                              // However, if we are considering starting a new partition from `prev_current_start_no_op`
                                              // and changing `s[i]`, then `s[i]` is unique. The `last_seen` state for this new partition
                                              // would be `last_seen_no_op` (from the *previous* step, before `s[i]` was processed)
                                              // but with `s[i]` marked as seen at `i`.
                                              // A simpler way: if we use the operation at `i`, the current partition effectively starts
                                              // at `prev_current_start_no_op` and `s[i]` is now unique.
                                              // So, the `last_seen` state for this new partition should be a fresh one,
                                              // considering only chars from `prev_current_start_no_op` to `i-1` (without `s[i]` causing a break)
                                              // and then `s[i]` as unique.
                                              // This means `last_seen_no_op` (from before `s[i]` was processed) is the base.
                                              // We need to re-scan `s[prev_current_start_no_op..i-1]` to get `last_seen_no_op_at_prev_current_start_no_op`.
                                              // This would be too slow.

            // Re-think Option B for `last_seen_op_B`:
            // If we use the operation at index `i`, then `s[i]` is changed.
            // The segment `s[prev_current_start_no_op .. i]` becomes a valid partition.
            // The `last_seen` state for this segment should be the `last_seen` state that was active at `prev_current_start_no_op`,
            // updated with all characters in `s[prev_current_start_no_op .. i-1]` and then `s[i]` as unique.
            // This is actually just `last_seen_no_op` as it was *before* `s[i]` was processed, with `s[i]` added.
            let mut temp_last_seen_no_op_for_option_B = [-1; 26];
            for k in prev_current_start_no_op as usize .. i {
                temp_last_seen_no_op_for_option_B[(chars[k] as u8 - b'a') as usize] = k as i32;
            }
            temp_last_seen_no_op_for_option_B[char_val] = i as i32; // s[i] is now unique

            // Compare and update dp_with_op and its state variables
            if val_A >= val_B {
                dp_with_op[i + 1] = val_A;
                current_start_with_op = current_start_op_A;
                last_seen_with_op = last_seen_op_A;
            } else {
                dp_with_op[i + 1] = val_B;
                current_start_with_op = current_start_op_B;
                last_seen_with_op = temp_last_seen_no_op_for_option_B;
            }
        }

        dp_with_op[n]
    }
}