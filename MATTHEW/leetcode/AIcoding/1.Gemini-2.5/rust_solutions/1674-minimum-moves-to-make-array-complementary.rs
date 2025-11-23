impl Solution {
    pub fn min_moves(nums: Vec<i32>, limit: i32) -> i32 {
        let n = nums.len();
        let max_possible_sum = 2 * limit;

        // `diff` array will store the change in the total number of moves
        // for each possible target sum `s`.
        // `diff[s]` represents `moves(s) - moves(s-1)`.
        // The possible sums range from 2 (1+1) to 2*limit (limit+limit).
        // We need indices up to `max_possible_sum + 1`.
        let mut diff = vec![0; (max_possible_sum + 2) as usize];

        for i in 0..(n / 2) {
            let mut a = nums[i];
            let mut b = nums[n - 1 - i];

            // Ensure a <= b for consistent range calculations
            if a > b {
                std::mem::swap(&mut a, &mut b);
            }

            // 1. Initial state: Any sum 's' requires 2 moves for this pair (changing both a and b).
            // This applies to sums from 2 up to 2*limit.
            // So, we add 2 to the count starting from sum 2.
            diff[2 as usize] += 2;
            // And remove this base contribution after 2*limit.
            diff[(max_possible_sum + 1) as usize] -= 2;

            // 2. One-move range: For sums 's' in [a + 1, b + limit], this pair needs 1 move.
            // This means we save 1 move compared to the base 2 moves.
            // So, from `a + 1`, we reduce the move count by 1.
            diff[(a + 1) as usize] -= 1;
            // This saving ends after `b + limit`. So, from `b + limit + 1`, we add 1 back.
            diff[(b + limit + 1) as usize] += 1;

            // 3. Zero-move sum: For sum 's' equal to `a + b`, this pair needs 0 moves.
            // This means we save another 1 move compared to the 1-move cost.
            // So, at `a + b`, we reduce the move count by another 1.
            diff[(a + b) as usize] -= 1;
            // This additional saving ends after `a + b`. So, from `a + b + 1`, we add 1 back.
            diff[(a + b + 1) as usize] += 1;
        }

        let mut current_moves = 0;
        let mut min_total_moves = std::i32::MAX;

        // Iterate through all possible target sums `s` from 2 to 2*limit.
        // Accumulate the changes to find the total moves for each `s`.
        for s in 2..=(max_possible_sum) {
            current_moves += diff[s as usize];
            min_total_moves = min_total_moves.min(current_moves);
        }

        min_total_moves
    }
}