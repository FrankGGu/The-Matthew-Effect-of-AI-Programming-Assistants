impl Solution {
    pub fn erase_overlap_intervals(mut intervals: Vec<Vec<i32>>) -> i32 {
        if intervals.is_empty() {
            return 0;
        }

        intervals.sort_unstable_by_key(|i| i[1]);

        let mut end = intervals[0][1];
        let mut count = 1;

        for i in 1..intervals.len() {
            if intervals[i][0] >= end {
                count += 1;
                end = intervals[i][1];
            }
        }

        intervals.len() as i32 - count
    }
}