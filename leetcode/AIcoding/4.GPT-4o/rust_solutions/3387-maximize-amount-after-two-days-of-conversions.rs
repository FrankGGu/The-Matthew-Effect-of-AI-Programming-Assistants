impl Solution {
    pub fn maximize_the_profit(n: i32, offer: Vec<Vec<i32>>) -> i32 {
        let mut dp = vec![0; (n + 1) as usize];
        for o in offer {
            let (start, end, profit) = (o[0], o[1], o[2]);
            for j in (end..=n).rev() {
                dp[j as usize] = dp[j as usize].max(dp[(j - (end - start + 1)) as usize] + profit);
            }
        }
        dp[n as usize]
    }
}