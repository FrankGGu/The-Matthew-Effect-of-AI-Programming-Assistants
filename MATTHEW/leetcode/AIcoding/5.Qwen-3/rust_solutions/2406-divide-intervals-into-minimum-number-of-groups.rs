impl Solution {

use std::collections::BinaryHeap;
use std::cmp::Reverse;

impl Solution {
    pub fn merge_groups(intervals: Vec<Vec<i32>>) -> i32 {
        let mut intervals = intervals;
        intervals.sort_by_key(|x| x[0]);
        let mut heap = BinaryHeap::new();

        for interval in intervals {
            if let Some(&end) = heap.peek() {
                if interval[0] > end {
                    heap.pop();
                }
            }
            heap.push(Reverse(interval[1]));
        }

        heap.len() as i32
    }
}
}