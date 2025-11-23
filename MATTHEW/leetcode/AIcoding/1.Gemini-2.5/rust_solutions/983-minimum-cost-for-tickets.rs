impl Solution {
    pub fn mincost_tickets(days: Vec<i32>, costs: Vec<i32>) -> i32 {
        let max_day = *days.last().unwrap() as usize;

        let mut travel_days_set = vec![false; max_day + 1];
        for &day in days.iter() {
            travel_days_set[day as usize] = true;
        }

        let mut dp = vec![0; max_day + 1];

        for i in 1..=max_day {
            if !travel_days_set[i] {
                dp[i] = dp[i - 1];
            } else {
                let cost_1_day = dp[i - 1] + costs[0];

                let cost_7_day_idx = i.saturating_sub(7);
                let cost_7_day = dp[cost_7_day_idx] + costs[1];

                let cost_30_day_idx = i.saturating_sub(30);
                let cost_30_day = dp[cost_30_day_idx] + costs[2];

                dp[i] = cost_1_day.min(cost_7_day).min(cost_30_day);
            }
        }

        dp[max_day]
    }
}