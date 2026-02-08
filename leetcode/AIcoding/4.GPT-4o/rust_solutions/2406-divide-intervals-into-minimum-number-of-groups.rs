use std::collections::BinaryHeap;

pub fn min_groups(intervals: Vec<Vec<i32>>) -> i32 {
    let mut ends: BinaryHeap<i32> = BinaryHeap::new();
    let mut intervals = intervals;

    intervals.sort_by_key(|interval| interval[0]);

    for interval in intervals {
        if let Some(&end) = ends.peek() {
            if end < interval[0] {
                ends.pop();
            }
        }
        ends.push(interval[1]);
    }

    ends.len() as i32
}