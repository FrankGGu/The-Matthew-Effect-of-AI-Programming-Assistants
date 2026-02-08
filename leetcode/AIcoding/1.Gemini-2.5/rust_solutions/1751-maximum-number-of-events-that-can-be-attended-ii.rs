impl Solution {
    pub fn max_value(mut events: Vec<Vec<i32>>, k: i32) -> i32 {
        events.sort_unstable_by_key(|e| e[0]);

        let n = events.len();
        let k_usize = k as usize;

        // dp[i][j] represents the maximum value that can be obtained by attending `j` events
        // from the events[i...] (i.e., events from index i to n-1).
        // The table size is (n+1) x (k+1).
        let mut dp = vec![vec![0; k_usize + 1]; n + 1];

        // Iterate backwards from the last event to the first.
        for i in (0..n).rev() {
            let current_event = &events[i];
            let end_day = current_event[1];
            let value = current_event[2];

            // Find the index of the first event that starts after the current_event ends.
            // This is equivalent to finding the lower_bound for `end_day + 1`
            // in the `start_day` of events in the subslice `events[i+1..n]`.
            let search_result = events[i + 1..n].binary_search_by_key(|e| e[0], &(end_day + 1));

            // `binary_search_by_key` returns `Ok(idx)` if an exact match is found,
            // or `Err(idx)` if not found, where `idx` is the insertion point
            // (the index where `end_day + 1` would be inserted to maintain sorted order).
            // This `idx` is exactly what we need for `lower_bound`.
            let next_event_sub_idx = match search_result {
                Ok(idx) => idx,
                Err(idx) => idx,
            };

            // Convert the subslice index to an index in the full `events` vector.
            let next_event_idx = (i + 1) + next_event_sub_idx;

            // Iterate for the number of events `j` from 1 up to k.
            for j in 1..=k_usize {
                // Option 1: Do not attend the current_event.
                // In this case, the maximum value is the same as considering events from `i+1` with `j` events.
                let option1 = dp[i + 1][j];

                // Option 2: Attend the current_event.
                // We add its value and then find the maximum value from `j-1` events
                // from the non-overlapping future events (starting from `next_event_idx`).
                let option2 = value + dp[next_event_idx][j - 1];

                // Take the maximum of the two options.
                dp[i][j] = option1.max(option2);
            }
        }

        // The result is the maximum value using `k` events from `events[0...]`.
        dp[0][k_usize]
    }
}