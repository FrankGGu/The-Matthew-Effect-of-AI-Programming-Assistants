impl Solution {

use std::cmp::Ordering;

impl Solution {
    pub fn remove_covered_intervals(mut intervals: Vec<Vec<i32>>) -> i32 {
        intervals.sort_by(|a, b| {
            if a[0] == b[0] {
                b[1].cmp(&a[1])
            } else {
                a[0].cmp(&b[0])
            }
        });

        let mut count = 1;
        let mut prev_end = intervals[0][1];

        for i in 1..intervals.len() {
            if intervals[i][1] > prev_end {
                count += 1;
                prev_end = intervals[i][1];
            }
        }

        count as i32
    }
}
}