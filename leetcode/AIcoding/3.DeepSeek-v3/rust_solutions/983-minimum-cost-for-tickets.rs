impl Solution {
    pub fn mincost_tickets(days: Vec<i32>, costs: Vec<i32>) -> i32 {
        let last_day = *days.last().unwrap() as usize;
        let mut dp = vec![0; last_day + 1];
        let mut day_idx = 0;

        for i in 1..=last_day {
            if i == days[day_idx] as usize {
                let one = dp[i.saturating_sub(1)] + costs[0];
                let seven = dp[i.saturating_sub(7)] + costs[1];
                let thirty = dp[i.saturating_sub(30)] + costs[2];
                dp[i] = one.min(seven).min(thirty);
                day_idx += 1;
                if day_idx == days.len() {
                    break;
                }
            } else {
                dp[i] = dp[i - 1];
            }
        }

        dp[last_day]
    }
}