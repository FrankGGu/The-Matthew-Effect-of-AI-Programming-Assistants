impl Solution {
    pub fn maximize_the_profit(n: i32, offers: Vec<Vec<i32>>) -> i32 {
        let n = n as usize;
        let mut dp = vec![0; n + 1];
        let mut grouped_offers = vec![vec![]; n];

        for offer in offers {
            let start = offer[0] as usize;
            let end = offer[1] as usize;
            let gold = offer[2];
            grouped_offers[end].push((start, gold));
        }

        for end in 1..=n {
            dp[end] = dp[end - 1];
            for &(start, gold) in &grouped_offers[end - 1] {
                dp[end] = dp[end].max(dp[start] + gold);
            }
        }

        dp[n]
    }
}