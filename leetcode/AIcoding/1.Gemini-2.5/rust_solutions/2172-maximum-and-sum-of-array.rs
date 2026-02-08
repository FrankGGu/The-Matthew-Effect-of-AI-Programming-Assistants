impl Solution {
    pub fn maximum_and_sum(nums: Vec<i32>, num_slots: i32) -> i32 {
        let n = nums.len();
        let num_slots_usize = num_slots as usize;

        // dp[mask] stores the maximum AND sum achievable for a given slot configuration `mask`.
        // Each slot `j` (from 0 to `num_slots - 1`) uses 2 bits in the mask to represent its state:
        // 00 (0) -> 0 items placed in the slot
        // 01 (1) -> 1 item placed in the slot
        // 10 (2) -> 2 items placed in the slot (slot is full)
        // The total mask length is `2 * num_slots`.
        let max_mask = 1 << (2 * num_slots_usize);
        let mut dp = vec![i32::MIN; max_mask];

        // Base case: With 0 numbers placed, all slots are empty (mask 0), and the sum is 0.
        dp[0] = 0;

        // Iterate through each number in the `nums` array.
        // For each number, we consider placing it into an available slot.
        for &num in nums.iter() {
            // Create a new DP array for the current number being placed.
            // This ensures that `num` is only placed once per iteration.
            let mut next_dp = vec![i32::MIN; max_mask];

            // Iterate through all possible previous slot configurations (masks).
            for mask in 0..max_mask {
                // If this `mask` state was not reachable with previous numbers, skip it.
                if dp[mask] == i32::MIN {
                    continue;
                }

                // Try placing the current `num` into each slot `j`.
                for j in 0..num_slots_usize {
                    // Get the current state of slot `j` from the `mask`.
                    // The state is represented by 2 bits starting at position `2 * j`.
                    let slot_state = (mask >> (2 * j)) & 0b11;

                    // If slot `j` has capacity (it currently holds 0 or 1 number).
                    if slot_state < 2 {
                        // Calculate the new state for slot `j` after placing `num`.
                        let next_slot_state = slot_state + 1;

                        // Calculate the `next_mask` by updating slot `j`'s state.
                        // First, clear the 2 bits corresponding to slot `j` in the `mask`.
                        // Then, set these 2 bits to `next_slot_state`.
                        let next_mask = (mask & !(0b11 << (2 * j))) | (next_slot_state << (2 * j));

                        // Update the `next_dp` table for the `next_mask`.
                        // The value of slot `j` is `j + 1`.
                        let current_and_sum = num & ((j + 1) as i32);
                        next_dp[next_mask] = next_dp[next_mask].max(dp[mask] + current_and_sum);
                    }
                }
            }
            // After processing all possible placements for the current `num`,
            // update the `dp` array to `next_dp` for the next iteration.
            dp = next_dp;
        }

        // After iterating through all numbers in `nums`, the maximum value in the final `dp` array
        // represents the maximum AND sum achievable.
        // Since `n` is always greater than or equal to 1, and `num_slots` is greater than or equal to 1,
        // at least one number will be placed, and `dp` will contain reachable states.
        *dp.iter().max().unwrap()
    }
}