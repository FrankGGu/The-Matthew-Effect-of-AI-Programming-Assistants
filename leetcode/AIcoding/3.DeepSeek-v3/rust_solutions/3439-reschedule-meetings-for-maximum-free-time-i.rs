impl Solution {
    pub fn max_free_time(schedule: Vec<Vec<i32>>) -> i32 {
        let mut intervals: Vec<(i32, i32)> = schedule.into_iter().flatten().collect();
        intervals.sort_unstable();

        let mut max_gap = 0;
        let mut prev_end = intervals[0].1;

        for interval in intervals.iter().skip(1) {
            let (start, end) = *interval;
            if start > prev_end {
                max_gap = max_gap.max(start - prev_end);
            }
            prev_end = prev_end.max(end);
        }

        max_gap
    }
}