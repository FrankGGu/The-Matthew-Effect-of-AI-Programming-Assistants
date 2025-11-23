use std::collections::BinaryHeap;
use std::cmp::Reverse;

impl Solution {
    pub fn min_interval(intervals: Vec<Vec<i32>>, queries: Vec<i32>) -> Vec<i32> {
        let mut intervals = intervals;
        intervals.sort_unstable_by_key(|i| i[0]);

        let mut queries_with_indices: Vec<(i32, usize)> = queries
            .into_iter()
            .enumerate()
            .map(|(i, q)| (q, i))
            .collect();
        queries_with_indices.sort_unstable_by_key(|(q_val, _)| *q_val);

        let mut result = vec![-1; queries_with_indices.len()];
        let mut min_heap: BinaryHeap<Reverse<(i32, i32)>> = BinaryHeap::new(); // Stores (length, end_point)
        let mut interval_idx = 0;

        for (query_val, original_idx) in queries_with_indices {
            // Add intervals whose start point is <= current query_val
            while interval_idx < intervals.len() && intervals[interval_idx][0] <= query_val {
                let start = intervals[interval_idx][0];
                let end = intervals[interval_idx][1];
                let length = end - start + 1;
                min_heap.push(Reverse((length, end)));
                interval_idx += 1;
            }

            // Remove intervals whose end point is < current query_val
            while let Some(Reverse((_length, end))) = min_heap.peek() {
                if *end < query_val {
                    min_heap.pop();
                } else {
                    // The top element is valid, and since it's a min-heap by length,
                    // and then by end_point (implicitly, if lengths are equal),
                    // any other element that covers the query must have a length >= current_length.
                    // So we can stop.
                    break; 
                }
            }

            // If heap is not empty, the top element has the minimum length
            if let Some(Reverse((length, _))) = min_heap.peek() {
                result[original_idx] = *length;
            }
        }

        result
    }
}