struct Solution;

impl Solution {
    pub fn bubble_shooter(nums: Vec<i32>, m: i32) -> i32 {
        let n = nums.len();
        if n == 0 {
            return 0; // No bubbles, 0 shots needed.
        }
        // If n < 3, it's impossible to burst all bubbles.
        // We need at least 3 consecutive bubbles to burst.
        // We can only replace existing bubbles, not add new ones to empty spots.
        // So, with 1 or 2 bubbles, we can never form a 3-chain.
        if n < 3 {
            return -1;
        }

        // Compress consecutive identical bubbles into blocks
        // Each block is represented as (color, count)
        let mut blocks: Vec<(i32, usize)> = Vec::new();
        if n > 0 {
            let mut current_color = nums[0];
            let mut current_count = 1;
            for i in 1..n {
                if nums[i] == current_color {
                    current_count += 1;
                } else {
                    blocks.push((current_color, current_count));
                    current_color = nums[i];
                    current_count = 1;
                }
            }
            blocks.push((current_color, current_count));
        }

        let num_blocks = blocks.len();
        // dp[i][j][k_total_i] = minimum shots to clear blocks[i...j],
        // where k_total_i is the total count of bubbles of color blocks[i].0
        // that are effectively merged with blocks[i] from its left.
        // k_total_i includes blocks[i].1 (the original count of block i).
        // The maximum possible value for k_total_i is n (if all original bubbles are the same color).
        let mut dp = vec![vec![vec![std::i32::MAX; n + 1]; num_blocks]; num_blocks];

        // Helper function to calculate the minimum shots to burst a single "merged" block
        // of `current_len` identical bubbles.
        // This assumes the bubbles are isolated and need to form a 3-chain by themselves.
        // If current_len == 0, 0 shots (already cleared).
        // If current_len == 1, 2 shots (e.g., [X] needs two more X's to become [X,X,X]).
        // If current_len == 2, 1 shot (e.g., [X,X] needs one more X to become [X,X,X]).
        // If current_len >= 3, 1 shot (e.g., [X,X,X] needs one trigger shot).
        let get_cost_for_single_block = |current_len: usize| -> i32 {
            if current_len == 0 {
                0
            } else if current_len == 1 {
                2
            } else { // current_len >= 2
                1
            }
        };

        // Base cases: single block (segment of length 1)
        for i in 0..num_blocks {
            // k_total_i represents the total count of bubbles of blocks[i].0,
            // including blocks[i].1 and any conceptual bubbles merged from the left.
            for k_total_i in blocks[i].1..=n { 
                dp[i][i][k_total_i] = get_cost_for_single_block(k_total_i);
            }
        }

        // Fill DP table for increasing segment lengths
        for len in 2..=num_blocks {
            for i in 0..=num_blocks - len {
                let j = i + len - 1;

                // Iterate over possible k_total_i values for blocks[i]
                for k_total_i in blocks[i].1..=n {
                    // Option 1: Clear blocks[i] (with its k_total_i merged bubbles) independently.
                    // Then clear the rest of the segment blocks[i+1...j].
                    let cost_clear_i = get_cost_for_single_block(k_total_i);

                    let cost_clear_rest = if i + 1 <= j {
                        // For blocks[i+1], its initial k_total is just its own count (blocks[i+1].1).
                        dp[i + 1][j][blocks[i + 1].1] 
                    } else {
                        0 // If i+1 > j, the rest is empty, cost is 0.
                    };

                    if cost_clear_i != std::i32::MAX && cost_clear_rest != std::i32::MAX {
                        dp[i][j][k_total_i] = dp[i][j][k_total_i].min(cost_clear_i + cost_clear_rest);
                    }

                    // Option 2: Find a block blocks[p] (where i < p <= j) with the same color as blocks[i].
                    // Clear the middle segment blocks[i+1...p-1].
                    // Then blocks[i] and blocks[p] merge, and we continue solving for blocks[p...j].
                    for p in (i + 1)..=j {
                        if blocks[p].0 == blocks[i].0 {
                            let cost_clear_middle = if i + 1 <= p - 1 {
                                // For blocks[i+1], its initial k_total is just its own count (blocks[i+1].1).
                                dp[i + 1][p - 1][blocks[i + 1].1] 
                            } else {
                                0 // If i+1 > p-1, middle segment is empty, cost is 0.
                            };

                            // Calculate the new k_total for blocks[p] after merging with blocks[i]
                            // This includes k_total_i (from blocks[i]) and blocks[p].1
                            let new_k_total_for_p = k_total_i + blocks[p].1; 

                            if new_k_total_for_p <= n && cost_clear_middle != std::i32::MAX {
                                let cost_clear_merged_and_rest = dp[p][j][new_k_total_for_p];
                                if cost_clear_merged_and_rest != std::i32::MAX {
                                    dp[i][j][k_total_i] = dp[i][j][k_total_i].min(
                                        cost_clear_middle + cost_clear_merged_and_rest
                                    );
                                }
                            }
                        }
                    }
                }
            }
        }

        // The final answer is the minimum shots to clear the entire sequence of blocks,
        // starting with blocks[0] having only its own count (no prior merged bubbles).
        let result = dp[0][num_blocks - 1][blocks[0].1];
        if result == std::i32::MAX {
            -1 // Indicates no solution found, though for valid inputs, a solution should always exist.
        } else {
            result
        }
    }
}