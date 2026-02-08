impl Solution {
    pub fn min_sessions(tasks: Vec<i32>, session_time: i32) -> i32 {
        let n = tasks.len();
        let mut dp = vec![(i32::MAX, i32::MAX); 1 << n];
        dp[0] = (1, 0);

        for mask in 1..(1 << n) {
            for i in 0..n {
                if mask & (1 << i) != 0 {
                    let prev_mask = mask ^ (1 << i);
                    let (sessions, current_time) = dp[prev_mask];
                    if current_time + tasks[i] <= session_time {
                        if sessions < dp[mask].0 || (sessions == dp[mask].0 && current_time + tasks[i] < dp[mask].1) {
                            dp[mask] = (sessions, current_time + tasks[i]);
                        }
                    } else {
                        if sessions + 1 < dp[mask].0 || (sessions + 1 == dp[mask].0 && tasks[i] < dp[mask].1) {
                            dp[mask] = (sessions + 1, tasks[i]);
                        }
                    }
                }
            }
        }

        dp[(1 << n) - 1].0
    }
}