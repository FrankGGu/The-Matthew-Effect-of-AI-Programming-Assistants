impl Solution {
    pub fn merge(intervals: Vec<Vec<i32>>) -> Vec<Vec<i32>> {
        let mut intervals = intervals;
        intervals.sort_by_key(|x| x[0]);
        let mut merged = Vec::new();

        for interval in intervals {
            if merged.is_empty() || merged.last().unwrap()[1] < interval[0] {
                merged.push(interval);
            } else {
                let last = merged.last_mut().unwrap();
                last[1] = last[1].max(interval[1]);
            }
        }

        merged
    }
}