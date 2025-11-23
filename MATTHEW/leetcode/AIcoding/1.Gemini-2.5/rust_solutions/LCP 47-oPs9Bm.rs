use std::collections::BinaryHeap;
use std::cmp::Reverse;

struct Solution;

impl Solution {
    pub fn entrance_security_check(processing_times: Vec<i32>, num_checkpoints: i32) -> i32 {
        if processing_times.is_empty() {
            return 0;
        }

        let k = num_checkpoints as usize;
        let mut heap = BinaryHeap::new();

        for _ in 0..k {
            heap.push(Reverse(0));
        }

        for time_needed in processing_times {
            let Reverse(mut earliest_finish_time) = heap.pop().unwrap();
            earliest_finish_time += time_needed;
            heap.push(Reverse(earliest_finish_time));
        }

        heap.into_iter().map(|Reverse(t)| t).max().unwrap()
    }
}