impl Solution {
    pub fn mincost_tickets(days: Vec<i32>, costs: Vec<i32>) -> i32 {
        let n = days.len();
        let mut dp = vec![0; n + 1];
        let mut day_set = days.iter().collect::<std::collections::HashSet<_>>();

        for i in 1..=n {
            dp[i] = dp[i - 1] + costs[0];
            for j in 0..i {
                if days[i - 1] - days[j] < 7 {
                    dp[i] = dp[i].min(dp[j] + costs[1]);
                }
                if days[i - 1] - days[j] < 30 {
                    dp[i] = dp[i].min(dp[j] + costs[2]);
                }
            }
        }

        dp[n]
    }
}