impl Solution {
    pub fn min_sessions(tasks: Vec<i32>, session_time: i32) -> i32 {
        let n = tasks.len();
        let mut dp = vec![i32::MAX; 1 << n];
        dp[0] = 0;

        for mask in 0..(1 << n) {
            let mut remaining_time = session_time;
            for j in 0..n {
                if mask & (1 << j) == 0 {
                    if remaining_time >= tasks[j] {
                        remaining_time -= tasks[j];
                    } else {
                        let next_mask = mask | (1 << j);
                        dp[next_mask] = dp[next_mask].min(dp[mask] + 1);
                        remaining_time = session_time - tasks[j];
                    }
                }
            }
            if remaining_time < session_time {
                dp[mask] = dp[mask].min(dp[mask] + 1);
            }
        }

        dp[(1 << n) - 1]
    }
}