impl Solution {
    pub fn mincost_tickets(days: Vec<i32>, costs: Vec<i32>) -> i32 {
        let n = days.len();
        let mut dp = vec![0; n + 1];

        for i in 1..=n {
            dp[i] = dp[i - 1] + costs[0];

            let mut j = i - 1;
            while j >= 1 && days[i - 1] - days[j - 1] < 7 {
                j -= 1;
            }
            dp[i] = dp[i].min(dp[j] + costs[1]);

            j = i - 1;
            while j >= 1 && days[i - 1] - days[j - 1] < 30 {
                j -= 1;
            }
            dp[i] = dp[i].min(dp[j] + costs[2]);
        }

        dp[n]
    }
}