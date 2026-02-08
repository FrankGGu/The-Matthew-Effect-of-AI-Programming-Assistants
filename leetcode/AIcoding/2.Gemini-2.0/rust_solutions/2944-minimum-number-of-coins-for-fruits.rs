impl Solution {
    pub fn minimum_coins(prices: Vec<i32>) -> i32 {
        let n = prices.len();
        let mut dp = vec![0; n + 1];

        for i in (0..n).rev() {
            let k = std::cmp::min(n, i + prices[i] as usize);
            dp[i] = prices[i] + *dp[i+1..=k].iter().min().unwrap();
        }

        dp[0]
    }
}