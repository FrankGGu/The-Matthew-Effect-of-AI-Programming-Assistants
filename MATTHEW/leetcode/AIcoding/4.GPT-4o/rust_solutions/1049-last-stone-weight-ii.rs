impl Solution {
    pub fn last_stone_weight_ii(stones: Vec<i32>) -> i32 {
        let sum: i32 = stones.iter().sum();
        let target = sum / 2;
        let n = stones.len();
        let mut dp = vec![0; target as usize + 1];

        for &stone in &stones {
            for j in (stone..=target).rev() {
                dp[j as usize] = dp[j as usize].max(dp[(j - stone) as usize] + stone);
            }
        }

        sum - 2 * dp[target as usize]
    }
}