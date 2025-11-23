impl Solution {

use std::cmp::Reverse;
use std::collections::BinaryHeap;

impl Solution {
    pub fn max_free_time(mut slots: Vec<Vec<i32>>, mut k: i32) -> i32 {
        slots.sort_by(|a, b| a[0].cmp(&b[0]));

        let mut pq = BinaryHeap::new();
        let mut result = 0;
        let mut i = 0;

        while k > 0 {
            while i < slots.len() && slots[i][0] <= result {
                pq.push(Reverse(slots[i][1]));
                i += 1;
            }

            if pq.is_empty() {
                break;
            }

            let end = pq.pop().unwrap().0;
            result = end;
            k -= 1;
        }

        result
    }
}
}