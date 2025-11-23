impl Solution {
    pub fn max_total_reward(reward_values: Vec<i32>) -> i32 {
        let mut rewards = reward_values;
        rewards.sort();
        rewards.dedup();
        let max_reward = *rewards.last().unwrap_or(&0);
        let mut dp = vec![false; max_reward as usize * 2 + 1];
        dp[0] = true;
        for &num in &rewards {
            for j in (0..num).rev() {
                if dp[j as usize] {
                    dp[(j + num) as usize] = true;
                }
            }
        }
        dp.iter().enumerate().rposition(|(i, &val)| val).unwrap_or(0) as i32
    }
}