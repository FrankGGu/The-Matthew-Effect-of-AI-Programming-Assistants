use std::collections::HashMap;

impl Solution {
    pub fn find_right_interval(intervals: Vec<Vec<i32>>) -> Vec<i32> {
        let n = intervals.len();
        let mut start_index: HashMap<i32, Vec<usize>> = HashMap::new();
        for i in 0..n {
            let start = intervals[i][0];
            start_index.entry(start).or_insert(Vec::new()).push(i);
        }

        let mut starts: Vec<i32> = start_index.keys().cloned().collect();
        starts.sort();

        let mut result = vec![-1; n];
        for i in 0..n {
            let end = intervals[i][1];
            let mut left = 0;
            let mut right = starts.len();
            while left < right {
                let mid = left + (right - left) / 2;
                if starts[mid] >= end {
                    right = mid;
                } else {
                    left = mid + 1;
                }
            }

            if left < starts.len() {
                let start = starts[left];
                if let Some(indices) = start_index.get(&start) {
                    for &index in indices {
                        result[i] = index as i32;
                        break;
                    }
                }
            }
        }

        result
    }
}