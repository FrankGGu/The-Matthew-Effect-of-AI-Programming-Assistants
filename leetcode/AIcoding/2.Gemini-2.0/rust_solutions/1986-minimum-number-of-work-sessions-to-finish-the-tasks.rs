impl Solution {
    pub fn min_sessions(tasks: Vec<i32>, session_time: i32) -> i32 {
        let n = tasks.len();
        let mut ans = n as i32;
        for mask in 0..(1 << n) {
            let mut sessions = 1;
            let mut current_session = 0;
            let mut used = vec![false; n];
            for i in 0..n {
                if (mask >> i) & 1 != 0 {
                    used[i] = true;
                    current_session += tasks[i];
                }
            }
            if current_session > session_time {
                continue;
            }
            let mut remaining_tasks = vec![];
            for i in 0..n {
                if !used[i] {
                    remaining_tasks.push(tasks[i]);
                }
            }
            if remaining_tasks.is_empty() {
                ans = ans.min(sessions);
                continue;
            }

            let mut dp = vec![i32::MAX; 1 << remaining_tasks.len()];
            dp[0] = 1;

            for mask2 in 1..(1 << remaining_tasks.len()) {
                let mut current_session2 = 0;
                let mut tasks_in_session = vec![];
                for i in 0..remaining_tasks.len() {
                    if (mask2 >> i) & 1 != 0 {
                        current_session2 += remaining_tasks[i];
                        tasks_in_session.push(i);
                    }
                }

                if current_session2 <= session_time {
                    dp[mask2] = 1;
                }

                for i in 0..remaining_tasks.len() {
                    if (mask2 >> i) & 1 != 0 {
                        let prev_mask = mask2 ^ (1 << i);
                        dp[mask2] = dp[mask2].min(dp[prev_mask]);
                    }
                }
            }

            if dp[(1 << remaining_tasks.len()) - 1] != i32::MAX {
                ans = ans.min(dp[(1 << remaining_tasks.len()) - 1] + 0);
            }

            let mut dp2 = vec![i32::MAX; 1 << remaining_tasks.len()];
            dp2[0] = 0;

            for mask2 in 1..(1 << remaining_tasks.len()) {
                for i in 0..remaining_tasks.len() {
                    if (mask2 >> i) & 1 != 0 {
                        let prev_mask = mask2 ^ (1 << i);
                        let mut current_session2 = 0;
                        for j in 0..remaining_tasks.len() {
                            if (mask2 >> j) & 1 != 0 {
                                current_session2 += remaining_tasks[j];
                            }
                        }
                        if current_session2 <= session_time {
                            dp2[mask2] = dp2[mask2].min(dp2[0] + 1);
                        }

                        let mut current_session3 = 0;
                        for j in 0..remaining_tasks.len() {
                            if ((mask2 ^ (1 << i)) >> j) & 1 != 0 {
                                current_session3 += remaining_tasks[j];
                            }
                        }
                        let mut session_with_i = 0;
                        session_with_i += remaining_tasks[i];
                        if session_with_i <= session_time {
                            dp2[mask2] = dp2[mask2].min(dp2[prev_mask] + 1);
                        }
                    }
                }
            }

             let mut dp3 = vec![i32::MAX; 1 << remaining_tasks.len()];
            dp3[0] = 0;

            for mask2 in 1..(1 << remaining_tasks.len()) {
                 dp3[mask2] = i32::MAX;
                for submask in 1..=mask2 {
                    if (mask2 & submask) == submask {
                        let mut current_session2 = 0;
                        for i in 0..remaining_tasks.len() {
                            if (submask >> i) & 1 != 0 {
                                current_session2 += remaining_tasks[i];
                            }
                        }
                        if current_session2 <= session_time {
                            dp3[mask2] = dp3[mask2].min(dp3[mask2 ^ submask] + 1);
                        }
                    }
                }

            }
            if dp3[(1 << remaining_tasks.len()) - 1] != i32::MAX {
                ans = ans.min(dp3[(1 << remaining_tasks.len()) - 1] + 1);
            }
        }
        ans
    }
}