impl Solution {
    pub fn remove_covered_intervals(intervals: Vec<Vec<i32>>) -> i32 {
        let mut sorted_intervals = intervals.clone();
        sorted_intervals.sort_by(|a, b| {
            if a[0] != b[0] {
                a[0].cmp(&b[0])
            } else {
                b[1].cmp(&a[1])
            }
        });

        let mut count = 0;
        let mut end = -1;
        for interval in sorted_intervals {
            if interval[1] > end {
                count += 1;
                end = interval[1];
            }
        }

        count
    }
}