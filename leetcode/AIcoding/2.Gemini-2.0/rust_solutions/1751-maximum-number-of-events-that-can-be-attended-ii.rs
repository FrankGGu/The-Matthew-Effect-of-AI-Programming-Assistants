impl Solution {
    pub fn max_value(events: Vec<Vec<i32>>, k: i32) -> i32 {
        let n = events.len();
        let mut events = events;
        events.sort_by(|a, b| a[0].cmp(&b[0]));
        let k = k as usize;

        let mut dp = vec![vec![0; k + 1]; n + 1];

        for i in 1..=n {
            for j in 1..=k {
                let start = events[i - 1][0];
                let value = events[i - 1][2];

                let mut l = 0;
                let mut r = i - 1;
                let mut next_event = -1;

                while l < r {
                    let mid = (l + r) / 2;
                    if events[mid][1] < start {
                        l = mid + 1;
                    } else {
                        r = mid;
                    }
                }

                if events[l][1] < start {
                    next_event = l as i32;
                } else if l > 0 && events[l-1][1] < start {
                    next_event = (l-1) as i32;
                }

                if next_event == -1 {
                  dp[i][j] = std::cmp::max(dp[i-1][j], value + 0);
                } else {
                  dp[i][j] = std::cmp::max(dp[i-1][j], value + dp[next_event as usize + 1][j-1]);
                }

                dp[i][j] = std::cmp::max(dp[i][j], dp[i-1][j]);
            }
        }

        dp[n][k]
    }
}