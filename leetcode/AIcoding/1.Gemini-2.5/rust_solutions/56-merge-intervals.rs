impl Solution {
    pub fn merge(mut intervals: Vec<Vec<i32>>) -> Vec<Vec<i32>> {
        if intervals.is_empty() {
            return Vec::new();
        }

        intervals.sort_unstable_by_key(|i| i[0]);

        let mut merged = Vec::new();
        for interval in intervals {
            if merged.is_empty() || merged.last().unwrap()[1] < interval[0] {
                merged.push(interval);
            } else {
                let last_merged = merged.last_mut().unwrap();
                last_merged[1] = last_merged[1].max(interval[1]);
            }
        }

        merged
    }
}