impl Solution {
    pub fn min_taps(n: i32, ranges: Vec<i32>) -> i32 {
        let n = n as usize;
        let mut intervals = vec![];
        for (i, &r) in ranges.iter().enumerate() {
            let left = (i as i32 - r).max(0) as usize;
            let right = (i as i32 + r).min(n as i32) as usize;
            intervals.push((left, right));
        }
        intervals.sort_by_key(|&(left, _)| left);

        let mut res = 0;
        let mut i = 0;
        let mut current_end = 0;
        let mut next_end = 0;

        while i < intervals.len() && current_end < n {
            while i < intervals.len() && intervals[i].0 <= current_end {
                next_end = next_end.max(intervals[i].1);
                i += 1;
            }
            if next_end == current_end {
                return -1;
            }
            current_end = next_end;
            res += 1;
        }

        if current_end >= n {
            res
        } else {
            -1
        }
    }
}