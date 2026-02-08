use std::collections::{HashMap, HashSet};

impl Solution {
    pub fn can_cross(stones: Vec<i32>) -> bool {
        if stones.len() == 0 {
            return false; // According to problem constraints, stones.len() >= 2.
        }

        // The first jump must be 1 unit. If the second stone is not at position 1,
        // the frog cannot make the first jump.
        if stones[1] != 1 {
            return false;
        }

        let last_stone_pos = *stones.last().unwrap();
        // dp[stone_pos] stores a set of possible jump sizes (k) that can land on stone_pos.
        let mut dp: HashMap<i32, HashSet<i32>> = HashMap::new();

        // Initialize dp for all stone positions with empty sets.
        for &stone_pos in stones.iter() {
            dp.insert(stone_pos, HashSet::new());
        }

        // The frog starts on the first stone (position 0).
        // We can model this by saying that to reach stone 0, a "jump" of size 0 was made.
        // This allows the logic for subsequent jumps (k-1, k, k+1) to correctly derive the first jump of 1.
        dp.get_mut(&0).unwrap().insert(0); 

        // Iterate through each stone.
        for &stone_pos in stones.iter() {
            // If the current stone is the last stone, we don't need to make further jumps from it.
            // We only care if it was reachable.
            if stone_pos == last_stone_pos {
                break; 
            }

            // Get the set of jump sizes that can reach the current stone.
            // We clone the set to avoid mutable/immutable borrow conflicts
            // when iterating over `dp` and simultaneously modifying `dp`.
            let current_jumps = dp.get(&stone_pos).unwrap().clone();

            // For each possible jump size `k` to the current stone.
            for &k in current_jumps.iter() {
                // Consider the three possible next jump sizes: k-1, k, k+1.
                for next_k_delta in [-1, 0, 1] {
                    let next_k = k + next_k_delta;

                    // A jump size must be positive.
                    if next_k > 0 { 
                        let next_stone_pos = stone_pos + next_k;

                        // Check if there is a stone at `next_stone_pos`.
                        if let Some(next_jumps_set) = dp.get_mut(&next_stone_pos) {
                            // If a stone exists, record that it can be reached with `next_k` jump.
                            next_jumps_set.insert(next_k);
                        }
                    }
                }
            }
        }

        // The frog can cross if the last stone has at least one recorded jump size.
        !dp.get(&last_stone_pos).unwrap().is_empty()
    }
}