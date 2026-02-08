impl Solution {
    pub fn maximize_amount(amount: i32, conversions: Vec<Vec<i32>>) -> i32 {
        let mut dp = vec![vec![0; amount as usize + 1]; conversions.len() + 1];

        for i in 1..=conversions.len() {
            let cost = conversions[i - 1][0];
            let gain = conversions[i - 1][1];
            let number = conversions[i - 1][2];

            for j in 0..=amount as usize {
                dp[i][j] = dp[i - 1][j];
                for k in 1..=number.min((j as i32 / cost).max(0)) as usize {
                    dp[i][j] = dp[i][j].max(dp[i - 1][j - k * cost as usize] + k as i32 * gain);
                }
            }
        }

        dp[conversions.len()][amount as usize]
    }
}