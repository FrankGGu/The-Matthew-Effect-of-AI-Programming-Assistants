impl Solution {
    pub fn min_taps(n: i32, ranges: Vec<i32>) -> i32 {
        let mut intervals = vec![];
        for i in 0..=n {
            let start = i - ranges[i as usize].min(i);
            let end = i + ranges[i as usize].min(n - i);
            intervals.push((start, end));
        }
        intervals.sort();

        let mut count = 0;
        let mut current_end = 0;
        let mut farthest = 0;
        let mut i = 0;

        while current_end < n {
            while i < intervals.len() && intervals[i].0 <= current_end {
                farthest = farthest.max(intervals[i].1);
                i += 1;
            }
            if farthest <= current_end {
                return -1;
            }
            current_end = farthest;
            count += 1;
        }

        count
    }
}