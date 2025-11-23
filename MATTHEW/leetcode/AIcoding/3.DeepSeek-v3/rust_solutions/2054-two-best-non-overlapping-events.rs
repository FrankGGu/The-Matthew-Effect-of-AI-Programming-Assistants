use std::cmp::max;

impl Solution {
    pub fn max_two_events(events: Vec<Vec<i32>>) -> i32 {
        let mut events = events;
        events.sort_unstable_by_key(|e| e[1]);
        let n = events.len();
        let mut dp = vec![0; n];
        dp[0] = events[0][2];
        for i in 1..n {
            dp[i] = max(dp[i - 1], events[i][2]);
        }
        let mut max_val = 0;
        for i in 0..n {
            let current_val = events[i][2];
            let left = 0;
            let right = i;
            let mut j = right;
            while j > left {
                let mid = (left + right) / 2;
                if events[mid][1] < events[i][0] {
                    left = mid + 1;
                } else {
                    right = mid;
                }
            }
            if events[left][1] < events[i][0] {
                max_val = max(max_val, current_val + dp[left]);
            } else if left > 0 {
                max_val = max(max_val, current_val + dp[left - 1]);
            } else {
                max_val = max(max_val, current_val);
            }
        }
        max_val
    }
}