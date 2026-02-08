impl Solution {
    pub fn remove_covered_intervals(intervals: Vec<Vec<i32>>) -> i32 {
        let mut intervals = intervals;
        intervals.sort_by_key(|x| (x[0], -x[1]));
        let mut count = 0;
        let mut end = 0;

        for interval in intervals {
            if interval[1] > end {
                count += 1;
                end = interval[1];
            }
        }

        count
    }
}