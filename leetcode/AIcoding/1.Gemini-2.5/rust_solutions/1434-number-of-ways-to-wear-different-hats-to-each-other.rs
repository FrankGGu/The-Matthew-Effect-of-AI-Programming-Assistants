impl Solution {
    pub fn number_ways(hats: Vec<Vec<i32>>) -> i32 {
        let n = hats.len();
        let max_hat_id = 40; // Hats are labeled from 1 to 40

        let mut hat_to_people: Vec<Vec<usize>> = vec![vec![]; max_hat_id + 1];
        for (person_idx, person_hats) in hats.iter().enumerate() {
            for &hat_id in person_hats {
                hat_to_people[hat_id as usize].push(person_idx);
            }
        }

        let mod_val = 1_000_000_007;

        // dp[mask] stores the number of ways to assign hats to people represented by 'mask'
        // using hats processed so far (from 1 up to the current hat_id).
        let mut dp: Vec<i32> = vec![0; 1 << n];
        dp[0] = 1; // Base case: 1 way to assign no hats to no people (empty set)

        // Iterate through each hat ID from 1 to max_hat_id
        for h in 1..=max_hat_id {
            // Create a new DP array for the current hat 'h'.
            // Initialize new_dp with current dp. This accounts for the case where hat 'h' is NOT used.
            let mut new_dp = dp.clone(); 

            // If no one likes this hat, new_dp will remain a copy of dp, which is correct
            // as no new assignments can be made with this hat.
            if hat_to_people[h].is_empty() {
                dp = new_dp;
                continue;
            }

            // Iterate through all possible masks (representing people who already have hats assigned)
            for mask in 0..(1 << n) {
                // If there are no ways to achieve this 'mask' with hats processed so far, skip.
                if dp[mask] == 0 {
                    continue;
                }

                // Try assigning hat 'h' to a person who likes it
                for &person_idx in &hat_to_people[h] {
                    // Check if this person already has a hat in the current 'mask'
                    if (mask & (1 << person_idx)) == 0 { // If person_idx is not in mask
                        // If not, assign hat 'h' to this person.
                        // The 'dp[mask]' ways that led to 'mask' (using hats 1..h-1)
                        // now contribute to 'next_mask' (using hats 1..h, with hat 'h' assigned to person_idx).
                        let next_mask = mask | (1 << person_idx);
                        new_dp[next_mask] = (new_dp[next_mask] + dp[mask]) % mod_val;
                    }
                }
            }
            dp = new_dp; // Update dp for the next iteration
        }

        // The final answer is the number of ways to assign hats to all 'n' people,
        // which corresponds to the mask where all bits are set.
        dp[(1 << n) - 1]
    }
}