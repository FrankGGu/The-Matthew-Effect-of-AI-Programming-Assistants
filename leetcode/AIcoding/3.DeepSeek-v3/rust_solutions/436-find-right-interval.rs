use std::collections::HashMap;

impl Solution {
    pub fn find_right_interval(intervals: Vec<Vec<i32>>) -> Vec<i32> {
        let mut starts = intervals.iter().enumerate().map(|(i, v)| (v[0], i)).collect::<Vec<_>>();
        starts.sort_unstable();
        let mut res = Vec::with_capacity(intervals.len());
        for interval in intervals {
            let target = interval[1];
            let idx = starts.binary_search_by_key(&target, |&(s, _)| s);
            let pos = match idx {
                Ok(i) => i,
                Err(i) => i,
            };
            if pos < starts.len() {
                res.push(starts[pos].1 as i32);
            } else {
                res.push(-1);
            }
        }
        res
    }
}