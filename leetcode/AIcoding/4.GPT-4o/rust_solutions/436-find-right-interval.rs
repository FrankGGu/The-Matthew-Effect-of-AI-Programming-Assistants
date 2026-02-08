use std::collections::HashMap;

pub fn find_right_interval(intervals: Vec<Vec<i32>>) -> Vec<i32> {
    let mut starts: Vec<(i32, usize)> = intervals.iter().enumerate().map(|(i, v)| (v[0], i)).collect();
    starts.sort_by_key(|&(start, _)| start);
    let mut result = vec![-1; intervals.len()];

    for (end, index) in intervals.iter().enumerate() {
        let mut left = 0;
        let mut right = starts.len() as i32;

        while left < right {
            let mid = (left + right) / 2;
            if starts[mid as usize].0 < index[1] {
                left = mid + 1;
            } else {
                right = mid;
            }
        }

        if left < starts.len() as i32 {
            result[index[0] as usize] = starts[left as usize].1 as i32;
        }
    }
    result
}