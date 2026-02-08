use std::collections::BinaryHeap;
use std::cmp::Reverse;

impl Solution {
    pub fn max_events(events: Vec<Vec<i32>>) -> i32 {
        let mut events = events;
        events.sort_by(|a, b| a[0].cmp(&b[0]));
        let mut heap = BinaryHeap::new();
        let mut day = 1;
        let mut res = 0;
        let mut i = 0;
        let n = events.len();

        while i < n || !heap.is_empty() {
            while i < n && events[i][0] == day {
                heap.push(Reverse(events[i][1]));
                i += 1;
            }

            while let Some(&Reverse(end)) = heap.peek() {
                if end < day {
                    heap.pop();
                } else {
                    break;
                }
            }

            if let Some(Reverse(_)) = heap.pop() {
                res += 1;
            }

            day += 1;
        }

        res
    }
}