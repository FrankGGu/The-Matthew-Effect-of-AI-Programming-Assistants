use std::cmp;

impl Solution {
    pub fn max_value(events: Vec<Vec<i32>>, k: i32) -> i32 {
        let mut events = events;
        events.sort_unstable_by(|a, b| a[1].cmp(&b[1]));
        let n = events.len();
        let k = k as usize;
        let mut dp = vec![vec![0; k + 1]; n + 1];

        for i in 1..=n {
            let (start, end, value) = (events[i-1][0], events[i-1][1], events[i-1][2]);
            let mut l = 0;
            let mut r = i - 1;
            while l < r {
                let mid = l + (r - l) / 2;
                if events[mid][1] < start {
                    l = mid + 1;
                } else {
                    r = mid;
                }
            }
            if events[l][1] < start {
                l += 1;
            }
            let last_non_overlapping = l;

            for j in 1..=k {
                dp[i][j] = cmp::max(dp[i-1][j], dp[last_non_overlapping][j-1] + value);
            }
        }

        dp[n][k]
    }
}