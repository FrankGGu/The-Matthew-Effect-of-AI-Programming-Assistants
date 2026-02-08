impl Solution {
    pub fn max_score_of_non_overlapping_intervals(intervals: Vec<Vec<i32>>) -> i32 {
        if intervals.is_empty() {
            return 0;
        }

        let mut sorted_intervals: Vec<(i32, i32, i32)> = intervals
            .into_iter()
            .map(|v| (v[0], v[1], v[2]))
            .collect();

        // Sort intervals by their end times
        sorted_intervals.sort_unstable_by_key(|&(_, end, _)| end);

        let n = sorted_intervals.len();
        let mut dp: Vec<i32> = vec![0; n];

        // Base case: The maximum score for the first interval is its own score
        dp[0] = sorted_intervals[0].2;

        for i in 1..n {
            let (current_start, _, current_score) = sorted_intervals[i];

            // Option 1: Do not include the current interval
            let score_without_current = dp[i - 1];

            // Option 2: Include the current interval
            let mut score_with_current = current_score;

            // Find the latest interval `j` that does not overlap with the current interval `i`.
            // This means `sorted_intervals[j].1 <= current_start`.
            // We perform a binary search on the `sorted_intervals` from index `0` to `i-1`.
            let mut low = 0;
            let mut high = i - 1;
            let mut latest_non_overlapping_idx = -1; // Stores the index of the latest non-overlapping interval

            while low <= high {
                let mid = low + (high - low) / 2;
                if sorted_intervals[mid].1 <= current_start {
                    latest_non_overlapping_idx = mid as i32;
                    low = mid + 1; // Try to find an even later non-overlapping interval
                } else {
                    high = mid - 1; // This interval overlaps, so look earlier
                }
            }

            // If a non-overlapping interval `j` was found, add its maximum score `dp[j]`
            if latest_non_overlapping_idx != -1 {
                score_with_current += dp[latest_non_overlapping_idx as usize];
            }

            // The maximum score for `i` is the maximum of the two options
            dp[i] = score_with_current.max(score_without_current);
        }

        *dp.last().unwrap_or(&0)
    }
}