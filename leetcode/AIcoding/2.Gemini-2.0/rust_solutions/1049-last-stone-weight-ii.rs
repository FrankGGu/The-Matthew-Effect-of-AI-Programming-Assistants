impl Solution {
    pub fn last_stone_weight_ii(stones: Vec<i32>) -> i32 {
        let sum: i32 = stones.iter().sum();
        let target = sum / 2;
        let mut dp = vec![false; target as usize + 1];
        dp[0] = true;

        for &stone in &stones {
            for j in (stone as usize..=target as usize).rev() {
                dp[j] = dp[j] || dp[j - stone as usize];
            }
        }

        for j in (0..=target as usize).rev() {
            if dp[j] {
                return sum - 2 * j as i32;
            }
        }

        0
    }
}