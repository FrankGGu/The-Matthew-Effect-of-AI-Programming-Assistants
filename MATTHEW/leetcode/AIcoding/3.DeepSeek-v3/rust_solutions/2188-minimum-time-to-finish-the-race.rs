impl Solution {
    pub fn minimum_finish_time(tires: Vec<Vec<i32>>, change_time: i32, num_laps: i32) -> i32 {
        let mut min_time_no_change = vec![i32::MAX; 20];
        for t in &tires {
            let (f, r) = (t[0], t[1]);
            let mut total = 0;
            let mut lap_time = f;
            for i in 1..20 {
                total += lap_time;
                if total > 1e5 as i32 {
                    break;
                }
                if total < min_time_no_change[i] {
                    min_time_no_change[i] = total;
                }
                lap_time *= r;
                if lap_time > 1e5 as i32 {
                    break;
                }
            }
        }

        let mut dp = vec![i32::MAX; num_laps as usize + 1];
        dp[0] = 0;
        for lap in 1..=num_laps as usize {
            for j in 1..20 {
                if j > lap {
                    continue;
                }
                let cost = if j == lap {
                    min_time_no_change[j]
                } else {
                    min_time_no_change[j] + change_time + dp[lap - j]
                };
                if cost < dp[lap] {
                    dp[lap] = cost;
                }
            }
        }
        dp[num_laps as usize]
    }
}