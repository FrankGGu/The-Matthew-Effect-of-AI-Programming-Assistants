impl Solution {

use std::cmp::Ordering;
use std::collections::BinaryHeap;

struct Solution;

impl Solution {
    pub fn max_taxi_earnings(mut trips: Vec<Vec<i32>>) -> i32 {
        trips.sort_by(|a, b| a[1].cmp(&b[1]));

        let mut heap = BinaryHeap::new();
        let mut max_earnings = 0;
        let mut i = 0;

        while i < trips.len() {
            let start = trips[i][0];
            let end = trips[i][1];
            let earning = trips[i][2];

            while let Some((prev_end, prev_earning)) = heap.pop() {
                if prev_end <= start {
                    max_earnings += prev_earning;
                } else {
                    heap.push((prev_end, prev_earning));
                    break;
                }
            }

            heap.push((end, earning));
            i += 1;
        }

        while let Some((_, earning)) = heap.pop() {
            max_earnings += earning;
        }

        max_earnings
    }
}
}