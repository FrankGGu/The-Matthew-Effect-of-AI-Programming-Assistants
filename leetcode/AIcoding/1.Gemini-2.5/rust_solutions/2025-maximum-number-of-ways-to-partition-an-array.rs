use std::collections::HashMap;
use std::cmp::max;

impl Solution {
    pub fn ways_to_partition(nums: Vec<i32>, k: i32) -> i32 {
        let n = nums.len();
        let mut prefix_sums: Vec<i64> = vec![0; n + 1];
        for i in 0..n {
            prefix_sums[i + 1] = prefix_sums[i] + nums[i] as i64;
        }

        let total_sum = prefix_sums[n];
        let mut max_ways = 0;

        // Case 0: No change
        if total_sum % 2 == 0 {
            let target_half_sum = total_sum / 2;
            let mut current_ways = 0;
            // Iterate through possible partition points (j from 0 to n-2)
            // The sum of the left part is prefix_sums[j+1].
            // j+1 ranges from 1 to n-1.
            for i in 1..n { 
                if prefix_sums[i] == target_half_sum {
                    current_ways += 1;
                }
            }
            max_ways = current_ways;
        }

        // Case 1: Change one element nums[i_changed] to k
        // We iterate i_changed from 0 to n-1.
        // `left_map` stores counts of prefix_sums[x] for x in [0, i_changed].
        // `right_map` stores counts of prefix_sums[x] for x in [i_changed+1, n-1].
        let mut left_map: HashMap<i64, i32> = HashMap::new();
        let mut right_map: HashMap<i64, i32> = HashMap::new();

        // Initial population of maps before the loop for `i_changed`
        // `left_map` starts with P[0]
        left_map.insert(0, 1);
        // `right_map` contains P[1] to P[n-1]
        for x in 1..n { // x represents j+1, ranges from 1 to n-1
            *right_map.entry(prefix_sums[x]).or_insert(0) += 1;
        }

        for i_changed in 0..n { // i_changed is the index of the element nums[i_changed] that is changed to k
            let old_val = nums[i_changed] as i64;
            let diff = k as i64 - old_val;
            let new_total_sum = total_sum + diff;

            let mut current_ways_for_this_i_changed = 0;
            if new_total_sum % 2 == 0 {
                let target_half_sum = new_total_sum / 2;

                // Partitions where the split point `j` is to the left of `i_changed` (`j < i_changed`).
                // The sum of the left part is `prefix_sums[j+1]`, which is unaffected by the change at `i_changed`.
                // We need `prefix_sums[j+1] == target_half_sum`.
                // `j+1` ranges from `1` to `i_changed`. These `prefix_sums[j+1]` values are in `left_map`.
                let count_left = *left_map.get(&target_half_sum).unwrap_or(&0);
                if target_half_sum == 0 { // `prefix_sums[0]` is 0, but an empty left partition is not valid.
                    current_ways_for_this_i_changed += count_left - 1;
                } else {
                    current_ways_for_this_i_changed += count_left;
                }

                // Partitions where the split point `j` is at or to the right of `i_changed` (`j >= i_changed`).
                // The sum of the left part is `prefix_sums[j+1] + diff`.
                // We need `prefix_sums[j+1] + diff == target_half_sum`, so `prefix_sums[j+1] == target_half_sum - diff`.
                // `j+1` ranges from `i_changed+1` to `n-1`. These `prefix_sums[j+1]` values are in `right_map`.
                let count_right = *right_map.get(&(target_half_sum - diff)).unwrap_or(&0);
                current_ways_for_this_i_changed += count_right;
            }

            max_ways = max(max_ways, current_ways_for_this_i_changed);

            // Update maps for the next iteration:
            // `prefix_sums[i_changed+1]` moves from `right_map` to `left_map`.
            // This update is relevant for the next `i_changed` value.
            // This is done only if `i_changed+1` is a valid prefix sum index for a partition (`i_changed+1 <= n-1`).
            if i_changed < n - 1 { 
                let val_to_move = prefix_sums[i_changed + 1];

                // Decrement count in right_map
                *right_map.get_mut(&val_to_move).unwrap() -= 1;
                if *right_map.get(&val_to_move).unwrap() == 0 {
                    right_map.remove(&val_to_move);
                }

                // Increment count in left_map
                *left_map.entry(val_to_move).or_insert(0) += 1;
            }
        }

        max_ways
    }
}