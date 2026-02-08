impl Solution {
    pub fn min_sessions(tasks: Vec<i32>, session_time: i32) -> i32 {
        let n = tasks.len();
        // dp[mask] stores a tuple: (minimum_sessions, minimum_remaining_time_in_last_session)
        // We want to minimize sessions first, then minimize the remaining time in the last session.
        // Initialize with (usize::MAX, 0) representing an unreachable state.
        let mut dp = vec![(usize::MAX, 0); 1 << n];

        // Base case: 0 tasks require 0 sessions and have 0 remaining time.
        // When the first task is added, it will start the first session.
        dp[0] = (0, 0);

        // Iterate through all possible masks (subsets of tasks)
        for mask in 0..(1 << n) {
            // If the current mask is unreachable, skip it
            if dp[mask].0 == usize::MAX {
                continue;
            }

            // Try to add each unassigned task to the current state
            for i in 0..n {
                // Check if task 'i' is not yet included in the current mask
                if (mask & (1 << i)) == 0 {
                    let next_mask = mask | (1 << i);
                    let current_sessions = dp[mask].0;
                    let current_remaining = dp[mask].1;
                    let task_duration = tasks[i];

                    let new_sessions: usize;
                    let new_remaining: i32;

                    // Attempt to fit the task into the current session
                    if current_remaining >= task_duration {
                        // Task fits in the current session
                        new_sessions = current_sessions;
                        new_remaining = current_remaining - task_duration;
                    } else {
                        // Task does not fit, a new session must be started
                        // If current_sessions is 0 (from dp[0]), this correctly becomes 1.
                        new_sessions = current_sessions + 1;
                        new_remaining = session_time - task_duration;
                    }

                    // Update dp[next_mask] if the new state is better
                    // A state (s1, r1) is better than (s2, r2) if:
                    // 1. s1 < s2 (fewer sessions)
                    // 2. s1 == s2 AND r1 < r2 (same sessions, but less remaining time in the last session,
                    //    meaning the session is packed more efficiently)
                    if new_sessions < dp[next_mask].0 {
                        dp[next_mask] = (new_sessions, new_remaining);
                    } else if new_sessions == dp[next_mask].0 {
                        if new_remaining < dp[next_mask].1 {
                            dp[next_mask].1 = new_remaining;
                        }
                    }
                }
            }
        }

        // The final answer is the minimum number of sessions for the mask representing all tasks.
        dp[(1 << n) - 1].0 as i32
    }
}