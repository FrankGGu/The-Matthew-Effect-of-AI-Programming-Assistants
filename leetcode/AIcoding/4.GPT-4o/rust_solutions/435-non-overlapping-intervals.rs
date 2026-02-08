impl Solution {
    pub fn erase_overlap_intervals(intervals: Vec<Vec<i32>>) -> i32 {
        let mut intervals = intervals;
        intervals.sort_by_key(|x| x[1]);
        let mut count = 0;
        let mut end = i32::MIN;

        for interval in intervals {
            if interval[0] >= end {
                end = interval[1];
            } else {
                count += 1;
            }
        }

        count
    }
}