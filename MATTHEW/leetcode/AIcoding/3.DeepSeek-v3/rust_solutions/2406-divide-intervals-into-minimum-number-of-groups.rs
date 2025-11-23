use std::collections::BinaryHeap;

impl Solution {
    pub fn min_groups(intervals: Vec<Vec<i32>>) -> i32 {
        let mut intervals = intervalls;
        intervals.sort_unstable_by_key(|v| v[0]);
        let mut heap = BinaryHeap::new();

        for interval in intervals {
            if let Some(&end) = heap.peek() {
                if -end < interval[0] {
                    heap.pop();
                }
            }
            heap.push(-interval[1]);
        }

        heap.len() as i32
    }
}