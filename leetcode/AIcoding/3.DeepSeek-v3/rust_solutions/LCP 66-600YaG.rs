use std::collections::BinaryHeap;

impl Solution {
    pub fn min_booths(events: Vec<Vec<i32>>) -> i32 {
        let mut events = events;
        events.sort_unstable_by_key(|e| e[0]);
        let mut heap = BinaryHeap::new();
        let mut max_booths = 0;
        for event in events {
            let start = event[0];
            let end = event[1];
            while let Some(&top) = heap.peek() {
                if -top <= start {
                    heap.pop();
                } else {
                    break;
                }
            }
            heap.push(-end);
            max_booths = max_booths.max(heap.len() as i32);
        }
        max_booths
    }
}