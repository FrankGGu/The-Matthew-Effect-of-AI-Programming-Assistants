impl Solution {
    pub fn find_right_interval(intervals: Vec<Vec<i32>>) -> Vec<i32> {
        let n = intervals.len();
        if n == 0 {
            return vec![];
        }

        let mut sorted_starts: Vec<(i32, usize)> = Vec::with_capacity(n);
        for (i, interval) in intervals.iter().enumerate() {
            sorted_starts.push((interval[0], i));
        }

        sorted_starts.sort_unstable_by_key(|&(start, _)| start);

        let mut ans = vec![-1; n];

        for (i, interval) in intervals.iter().enumerate() {
            let end_i = interval[1];

            match sorted_starts.binary_search_by_key(&end_i, |&(start, _)| start) {
                Ok(idx) => {
                    ans[i] = sorted_starts[idx].1 as i32;
                }
                Err(idx) => {
                    if idx < n {
                        ans[i] = sorted_starts[idx].1 as i32;
                    } else {
                        ans[i] = -1;
                    }
                }
            }
        }

        ans
    }
}