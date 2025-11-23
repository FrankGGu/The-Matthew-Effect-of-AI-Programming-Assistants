impl Solution {
    pub fn erase_overlap_intervals(intervals: Vec<Vec<i32>>) -> i32 {
        if intervals.is_empty() {
            return 0;
        }
        let mut intervals = intervals;
        intervals.sort_by(|a, b| a[1].cmp(&b[1]));
        let mut count = 0;
        let mut end = intervals[0][1];
        for i in 1..intervals.len() {
            if intervals[i][0] < end {
                count += 1;
            } else {
                end = intervals[i][1];
            }
        }
        count
    }
}