impl Solution {

use std::collections::BinaryHeap;

impl Solution {
    pub fn max_events(mut events: Vec<Vec<i32>>) -> i32 {
        events.sort_unstable_by(|a, b| a[1].cmp(&b[1]));
        let mut heap = BinaryHeap::new();
        let mut count = 0;
        let mut i = 0;
        let n = events.len();

        while i < n || !heap.is_empty() {
            if i < n && events[i][0] <= count + 1 {
                heap.push(std::cmp::Reverse(events[i][1]));
                i += 1;
            } else {
                if heap.is_empty() {
                    break;
                }
                heap.pop();
                count += 1;
            }
        }

        count
    }
}
}