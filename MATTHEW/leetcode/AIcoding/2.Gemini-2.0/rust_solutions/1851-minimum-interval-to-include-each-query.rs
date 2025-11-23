use std::collections::BinaryHeap;
use std::cmp::Reverse;

impl Solution {
    pub fn min_interval(intervals: Vec<Vec<i32>>, queries: Vec<i32>) -> Vec<i32> {
        let mut sorted_intervals = intervals.clone();
        sorted_intervals.sort_by_key(|interval| interval[0]);

        let mut indexed_queries: Vec<(usize, i32)> = queries.iter().enumerate().map(|(i, &q)| (i, q)).collect();
        indexed_queries.sort_by_key(|&(_, q)| q);

        let mut result = vec![-1; queries.len()];
        let mut heap: BinaryHeap<Reverse<(i32, i32)>> = BinaryHeap::new();
        let mut interval_index = 0;

        for (query_index, query) in indexed_queries {
            while interval_index < sorted_intervals.len() && sorted_intervals[interval_index][0] <= query {
                let interval = &sorted_intervals[interval_index];
                heap.push(Reverse((interval[1] - interval[0] + 1, interval[1])));
                interval_index += 1;
            }

            while let Some(Reverse((len, end))) = heap.peek() {
                if *end < query {
                    heap.pop();
                } else {
                    break;
                }
            }

            if let Some(Reverse((len, _))) = heap.peek() {
                result[query_index] = *len;
            }
        }

        result
    }
}