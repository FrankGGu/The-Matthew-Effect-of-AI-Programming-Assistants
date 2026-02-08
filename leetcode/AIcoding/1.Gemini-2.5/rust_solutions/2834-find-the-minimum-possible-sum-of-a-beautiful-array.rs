impl Solution {
    pub fn minimum_sum(n: i32, target: i32) -> i64 {
        let n_long = n as i64;
        let target_long = target as i64;

        // 'limit_of_initial_safe_numbers' represents the largest number 'x' such that 'x'
        // can be picked and its complement 'target - x' is either greater than 'x'
        // and not yet considered, or 'target - x' equals 'x' (i.e., x = target/2)
        // which is allowed since array elements must be unique.
        // For example, if target = 4, target/2 = 2. We can pick 1 and 2.
        // 1 + 2 = 3 (not target).
        // If target = 6, target/2 = 3. We can pick 1, 2, and 3.
        // 1+2=3, 1+3=4, 2+3=5 (none are target).
        let limit_of_initial_safe_numbers = target_long / 2;

        let mut total_sum: i64 = 0;

        // Phase 1: Pick numbers from 1 up to 'limit_of_initial_safe_numbers',
        // or up to 'n', whichever is smaller. These numbers do not create any conflicts
        // among themselves.
        let num_from_first_phase = n_long.min(limit_of_initial_safe_numbers);

        // Sum of the arithmetic progression 1, 2, ..., num_from_first_phase
        total_sum += num_from_first_phase * (num_from_first_phase + 1) / 2;

        // Phase 2: If we still need more numbers after Phase 1.
        let remaining_n = n_long - num_from_first_phase;

        if remaining_n > 0 {
            // The numbers 1, ..., num_from_first_phase have been picked.
            // For any picked number 'x', 'target - x' is forbidden.
            // The numbers from 'num_from_first_phase + 1' up to 'target - 1'
            // are all forbidden because their complements (target - y) would be
            // within the '1, ..., num_from_first_phase' range (or equal to some y).
            // For example, if num_from_first_phase = target/2, then target/2 + 1
            // is forbidden because target - (target/2 + 1) = target/2 - 1 (if target even)
            // or target - (target/2 + 1) = target/2 (if target odd).
            // In either case, the complement is a number that would have been picked in Phase 1.
            // Therefore, the next available smallest number that is not forbidden is 'target'.
            // We need to pick 'remaining_n' numbers starting from 'target'.
            // These will be target, target + 1, ..., target + remaining_n - 1.
            let first_remaining = target_long;
            let last_remaining = target_long + remaining_n - 1;

            // Sum of this new arithmetic progression
            total_sum += remaining_n * (first_remaining + last_remaining) / 2;
        }

        total_sum
    }
}