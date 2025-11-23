impl Solution {

use std::cmp::Reverse;

impl Solution {
    pub fn min_processing_time(queries: Vec<Vec<i32>>) -> Vec<i32> {
        let mut processing_times = queries.iter().map(|q| q[1]).collect::<Vec<_>>();
        let mut query_indices = queries.iter().enumerate().map(|(i, q)| (q[0], i)).collect::<Vec<_>>();

        processing_times.sort_unstable();
        query_indices.sort_by_key(|&(time, i)| (Reverse(time), i));

        let mut result = vec![0; queries.len()];
        for (i, &(time, idx)) in query_indices.iter().enumerate() {
            result[idx] = time + processing_times[i];
        }

        result
    }
}
}