impl Solution {

use std::cmp::Ordering;
use std::collections::BTreeSet;

impl Solution {
    pub fn max_events(mut events: Vec<Vec<i32>>) -> i32 {
        events.sort_by(|a, b| {
            if a[1] != b[1] {
                a[1].cmp(&b[1])
            } else {
                a[0].cmp(&b[0])
            }
        });

        let n = events.len();
        let mut dp = vec![0; n + 1];
        let mut events = events.into_iter().enumerate().map(|(i, e)| (e[0], e[1], i)).collect::<Vec<_>>();

        events.sort_by(|a, b| {
            if a.1 != b.1 {
                a.1.cmp(&b.1)
            } else {
                a.0.cmp(&b.0)
            }
        });

        let mut last_day = 0;
        let mut event_set = BTreeSet::new();

        for i in 0..n {
            let (start, end, idx) = events[i];
            while last_day < start {
                if let Some(&event_idx) = event_set.iter().next() {
                    dp[event_idx + 1] = dp[event_idx + 1].max(dp[event_idx] + 1);
                    event_set.remove(&event_idx);
                } else {
                    break;
                }
                last_day += 1;
            }

            event_set.insert(idx);
        }

        while !event_set.is_empty() {
            if let Some(&event_idx) = event_set.iter().next() {
                dp[event_idx + 1] = dp[event_idx + 1].max(dp[event_idx] + 1);
                event_set.remove(&event_idx);
            }
            last_day += 1;
        }

        dp[n]
    }
}
}