use std::collections::HashMap;
use std::cmp::max;

impl Solution {
    pub fn max_fresh_donuts(batch_size: i32, groups: Vec<i32>) -> i32 {
        let mut initial_groups = 0;
        let mut counts = vec![0; batch_size as usize];

        for &group_size in &groups {
            let remainder = group_size % batch_size;
            if remainder == 0 {
                initial_groups += 1;
            } else {
                counts[remainder as usize] += 1;
            }
        }

        let mut current_ans = initial_groups;

        // Greedy pairing for remainders r and (batch_size - r)
        // These pairs directly form a group.
        for r in 1..(batch_size / 2) {
            let pairs = counts[r as usize].min(counts[(batch_size - r) as usize]);
            current_ans += pairs;
            counts[r as usize] -= pairs;
            counts[(batch_size - r) as usize] -= pairs;
        }

        // Handle the special case where batch_size is even and r = batch_size / 2
        // These groups pair with themselves.
        if batch_size % 2 == 0 {
            let r_half = batch_size / 2;
            let pairs_half = counts[r_half as usize] / 2;
            current_ans += pairs_half;
            counts[r_half as usize] %= 2; // At most one group of batch_size/2 remainder remains
        }

        // After greedy pre-processing, for each remainder `i` (1 to batch_size-1),
        // `counts[i]` can be at most 1. This is because for any `r`, if `counts[r]` is non-zero,
        // then `counts[batch_size - r]` must be zero (unless `r == batch_size / 2`, in which case `counts[r]` is at most 1).
        // This allows us to use a bitmask for the remaining counts.

        let mut memo: HashMap<(u8, u8), i32> = HashMap::new();
        let final_batch_size = batch_size as u8;

        // Build the initial mask for the DFS
        let mut initial_mask: u8 = 0;
        for i in 1..final_batch_size {
            if counts[i as usize] > 0 {
                initial_mask |= (1 << (i - 1)); // Set the (i-1)-th bit if remainder i exists
            }
        }

        // The DFS calculates additional groups that can be formed from the remaining donuts.
        // We start with a current_rem of 0, indicating a fresh batch.
        current_ans += Self::dfs(0, initial_mask, final_batch_size, &mut memo);

        current_ans
    }

    // `dfs` returns the maximum additional groups that can be formed
    // given the current remainder in the batch and the available donut groups (represented by mask).
    fn dfs(current_rem: u8, mask: u8, batch_size: u8, memo: &mut HashMap<(u8, u8), i32>) -> i32 {
        // Base case: If no more groups are available, no more additional groups can be formed.
        if mask == 0 {
            return 0;
        }

        let key = (current_rem, mask);
        if let Some(&res) = memo.get(&key) {
            return res;
        }

        let mut max_additional_groups = 0;

        // Iterate through all possible remainder values (1 to batch_size-1)
        for i in 1..batch_size {
            // Check if a group with remainder `i` is available in the mask
            if (mask & (1 << (i - 1))) != 0 {
                // If available, try taking this group
                let new_mask = mask ^ (1 << (i - 1)); // Remove this group from the mask
                let next_rem = (current_rem + i) % batch_size;

                let current_path_groups;
                if next_rem == 0 {
                    // If taking this group completes a batch (sum % batch_size == 0),
                    // we get 1 new group and start a new batch (current_rem = 0) for the next recursive call.
                    current_path_groups = 1 + Self::dfs(0, new_mask, batch_size, memo);
                } else {
                    // If taking this group does not complete a batch,
                    // we continue the current batch with the new remainder.
                    current_path_groups = Self::dfs(next_rem, new_mask, batch_size, memo);
                }
                // Update `max_additional_groups` with the best result from this path.
                max_additional_groups = max(max_additional_groups, current_path_groups);
            }
        }

        // Memoize the result before returning
        memo.insert(key, max_additional_groups);
        max_additional_groups
    }
}