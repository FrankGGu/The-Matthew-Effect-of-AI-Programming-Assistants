impl Solution {
    pub fn merge(intervals: Vec<Vec<i32>>) -> Vec<Vec<i32>> {
        if intervals.is_empty() {
            return Vec::new();
        }

        let mut intervals = intervals;
        intervals.sort_by(|a, b| a[0].cmp(&b[0]));

        let mut merged: Vec<Vec<i32>> = Vec::new();
        merged.push(intervals[0].clone());

        for i in 1..intervals.len() {
            let current_interval = &intervals[i];
            let last_merged = merged.last_mut().unwrap();

            if current_interval[0] <= last_merged[1] {
                last_merged[1] = last_merged[1].max(current_interval[1]);
            } else {
                merged.push(current_interval.clone());
            }
        }

        merged
    }
}