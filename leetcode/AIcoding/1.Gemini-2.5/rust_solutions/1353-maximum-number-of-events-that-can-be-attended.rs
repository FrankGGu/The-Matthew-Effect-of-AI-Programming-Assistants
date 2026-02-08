use std::collections::BinaryHeap;
use std::cmp::Reverse;

impl Solution {
    pub fn max_events(mut events: Vec<Vec<i32>>) -> i32 {
        events.sort_unstable_by_key(|e| e[0]);

        let mut attended_count = 0;
        let mut min_heap = BinaryHeap::new();

        let mut event_ptr = 0;
        let n = events.len();

        let mut current_day = 1;

        while event_ptr < n || !min_heap.is_empty() {
            if min_heap.is_empty() && event_ptr < n {
                current_day = events[event_ptr][0];
            }

            while event_ptr < n && events[event_ptr][0] <= current_day {
                min_heap.push(Reverse(events[event_ptr][1]));
                event_ptr += 1;
            }

            while let Some(&Reverse(end_time)) = min_heap.peek() {
                if end_time < current_day {
                    min_heap.pop();
                } else {
                    break;
                }
            }

            if let Some(_) = min_heap.pop() {
                attended_count += 1;
            }

            current_day += 1;
        }

        attended_count
    }
}