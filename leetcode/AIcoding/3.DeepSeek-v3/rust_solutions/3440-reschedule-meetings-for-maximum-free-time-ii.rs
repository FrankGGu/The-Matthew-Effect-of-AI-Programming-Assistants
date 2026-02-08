use std::collections::BinaryHeap;

impl Solution {
    pub fn max_free_time(schedule: Vec<Vec<i32>>) -> i32 {
        let mut intervals: Vec<(i32, i32)> = schedule.into_iter().flatten().collect();
        intervals.sort_unstable();

        let mut heap = BinaryHeap::new();
        let mut max_free = 0;

        for (start, end) in intervals {
            if let Some(&last_end) = heap.peek() {
                if last_end < start {
                    max_free = max_free.max(start - last_end);
                }
            }
            heap.push(end);
        }

        max_free
    }
}