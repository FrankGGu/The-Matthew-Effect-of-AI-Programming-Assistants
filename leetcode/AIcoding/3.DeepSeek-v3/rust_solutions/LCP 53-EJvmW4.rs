impl Solution {
    pub fn defend_space_city(time: Vec<i32>, position: Vec<i32>) -> i32 {
        let n = position.len();
        let mut events = Vec::with_capacity(n);
        for i in 0..n {
            events.push((position[i], time[i]));
        }
        events.sort_unstable();

        let mut dp = vec![vec![i32::MAX; 3]; n];
        for i in 0..n {
            let (pos, t) = events[i];
            if i == 0 {
                dp[i][0] = 1;
                dp[i][1] = 2;
                dp[i][2] = 3;
            } else {
                let (prev_pos, prev_t) = events[i - 1];
                if pos == prev_pos {
                    dp[i][0] = dp[i - 1][0] + 1;
                    dp[i][1] = dp[i - 1][1] + 2;
                    dp[i][2] = dp[i - 1][2] + 3;
                } else {
                    let mut min_prev = *dp[i - 1].iter().min().unwrap();
                    dp[i][0] = min_prev + 1;
                    dp[i][1] = min_prev + 2;
                    dp[i][2] = min_prev + 3;
                }
            }
        }

        *dp[n - 1].iter().min().unwrap()
    }
}