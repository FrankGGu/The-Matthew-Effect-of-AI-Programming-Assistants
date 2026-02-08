impl Solution {
    pub fn remove_covered_intervals(mut intervals: Vec<Vec<i32>>) -> i32 {
        intervals.sort_unstable_by(|a, b| {
            if a[0] != b[0] {
                a[0].cmp(&b[0])
            } else {
                b[1].cmp(&a[1])
            }
        });

        let mut count = 0;
        let mut prev_end = -1;

        for interval in intervals {
            let current_end = interval[1];
            if current_end > prev_end {
                count += 1;
                prev_end = current_end;
            }
        }

        count
    }
}