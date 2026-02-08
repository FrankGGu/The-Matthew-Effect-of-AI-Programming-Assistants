use std::collections::BinaryHeap;
use std::cmp::Reverse;

impl Solution {
    pub fn min_groups(intervals: Vec<Vec<i32>>) -> i32 {
        let mut intervals = intervals;
        intervals.sort_by(|a, b| a[0].cmp(&b[0]));
        let mut heap: BinaryHeap<Reverse<i32>> = BinaryHeap::new();
        for interval in intervals {
            if let Some(Reverse(end)) = heap.peek() {
                if *end < interval[0] {
                    heap.pop();
                }
            }
            heap.push(Reverse(interval[1]));
        }
        heap.len() as i32
    }
}