use std::collections::BinaryHeap;
use std::cmp::Reverse;

impl Solution {
    pub fn max_events(events: Vec<Vec<i32>>) -> i32 {
        let mut events = events;
        events.sort_by(|a, b| a[0].cmp(&b[0]));
        let mut heap: BinaryHeap<Reverse<i32>> = BinaryHeap::new();
        let mut ans = 0;
        let mut i = 0;
        let mut day = 1;

        while i < events.len() || !heap.is_empty() {
            while i < events.len() && events[i][0] <= day {
                heap.push(Reverse(events[i][1]));
                i += 1;
            }

            while !heap.is_empty() && heap.peek().unwrap().0 < day {
                heap.pop();
            }

            if !heap.is_empty() {
                heap.pop();
                ans += 1;
            }

            day += 1;
        }

        ans
    }
}