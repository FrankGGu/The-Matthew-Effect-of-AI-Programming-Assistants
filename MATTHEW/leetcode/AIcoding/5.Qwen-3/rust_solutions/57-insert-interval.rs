impl Solution {

use std::cmp::Ordering;

#[derive(PartialEq, Eq, Clone, Debug)]
pub struct Interval {
    pub start: i32,
    pub end: i32,
}

impl Solution {
    pub fn insert(intervals: Vec<Vec<i32>>, new_interval: Vec<i32>) -> Vec<Vec<i32>> {
        let mut result = Vec::new();
        let mut i = 0;
        let n = intervals.len();
        let new_start = new_interval[0];
        let new_end = new_interval[1];

        while i < n && intervals[i][1] < new_start {
            result.push(intervals[i].clone());
            i += 1;
        }

        while i < n && intervals[i][0] <= new_end {
            new_start = new_start.min(intervals[i][0]);
            new_end = new_end.max(intervals[i][1]);
            i += 1;
        }

        result.push(vec![new_start, new_end]);

        while i < n {
            result.push(intervals[i].clone());
            i += 1;
        }

        result
    }
}
}