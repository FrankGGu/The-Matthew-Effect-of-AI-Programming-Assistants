impl Solution {

use std::cmp::Reverse;
use std::collections::BinaryHeap;

impl Solution {
    pub fn max_free_time(mut slots: Vec<Vec<i32>>) -> i32 {
        slots.sort_by(|a, b| a[0].cmp(&b[0]));
        let mut heap = BinaryHeap::new();
        let mut result = 0;
        let mut prev_end = 0;

        for slot in slots {
            if prev_end < slot[0] {
                result += slot[0] - prev_end;
            }
            prev_end = prev_end.max(slot[1]);
        }

        result
    }
}
}