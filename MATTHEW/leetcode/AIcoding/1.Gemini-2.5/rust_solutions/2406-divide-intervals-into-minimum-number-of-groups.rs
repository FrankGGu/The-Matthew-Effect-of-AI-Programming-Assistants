use std::collections::BinaryHeap;
use std::cmp::Reverse;

impl Solution {
    pub fn min_groups(mut intervals: Vec<Vec<i32>>) -> i32 {
        // Sort intervals by their start times.
        intervals.sort_unstable_by_key(|i| i[0]);

        // Min-heap to store the end times of the latest interval in each group.
        // We use Reverse to simulate a min-heap with Rust's BinaryHeap (which is a max-heap).
        let mut groups_end_times: BinaryHeap<Reverse<i32>> = BinaryHeap::new();

        for interval in intervals {
            let start = interval[0];
            let end = interval[1];

            // If there's an existing group whose latest interval ends strictly before
            // the current interval's start time, we can reuse that group.
            // The condition for two intervals [a, b] and [c, d] to NOT overlap
            // is b < c or d < a.
            // Here, we check if the current interval [start, end] can be placed
            // into a group whose latest interval ended at `earliest_end_time`.
            // This is possible if `earliest_end_time < start`.
            if let Some(Reverse(earliest_end_time)) = groups_end_times.peek() {
                if start > *earliest_end_time {
                    // Reuse this group: remove its old end time and add the new one.
                    groups_end_times.pop();
                }
            }
            // Add the current interval's end time to the heap.
            // This either extends an existing group (after popping) or starts a new one.
            groups_end_times.push(Reverse(end));
        }

        // The number of elements in the heap is the minimum number of groups.
        groups_end_times.len() as i32
    }
}