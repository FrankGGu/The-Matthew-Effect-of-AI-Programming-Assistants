impl Solution {
    pub fn merge(mut intervals: Vec<Vec<i32>>) -> Vec<Vec<i32>> {
        if intervals.is_empty() {
            return vec![];
        }

        intervals.sort_unstable_by_key(|interval| interval[0]);

        let mut merged = Vec::new();
        for interval in intervals {
            if merged.is_empty() || merged.last().unwrap()[1] < interval[0] {
                merged.push(interval);
            } else {
                let last_merged_end = &mut merged.last_mut().unwrap()[1];
                *last_merged_end = (*last_merged_end).max(interval[1]);
            }
        }

        merged
    }
}