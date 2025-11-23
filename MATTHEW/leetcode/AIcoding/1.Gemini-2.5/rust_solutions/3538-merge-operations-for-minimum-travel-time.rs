impl Solution {
    pub fn merge_operations_for_minimum_travel_time(travel: Vec<i32>, max_time: i32) -> i32 {
        let n = travel.len();
        // dp[i] represents the minimum total travel time for a valid partitioning
        // of the prefix travel[0...i-1] into segments.
        // Each segment's sum must be <= max_time.
        let mut dp = vec![i32::MAX; n + 1];
        dp[0] = 0; // Base case: an empty prefix has 0 total travel time.

        for i in 1..=n {
            let mut current_segment_sum = 0;
            // Try to form the last segment ending at travel[i-1]
            // by extending from previous valid partition points j.
            for j in (0..i).rev() {
                current_segment_sum += travel[j]; // Add travel[j] to the current segment sum

                // If the current segment sum exceeds max_time,
                // then any segment starting before j and ending at i-1 will also exceed max_time.
                // So, we can stop extending this segment further back.
                if current_segment_sum > max_time {
                    break;
                }

                // If dp[j] is not MAX, it means travel[0...j-1] can be partitioned validly.
                // Then, we can form a new partition by taking travel[j...i-1] as the last segment.
                if dp[j] != i32::MAX {
                    dp[i] = dp[i].min(dp[j] + current_segment_sum);
                }
            }
        }

        dp[n]
    }
}