impl Solution {
    pub fn last_stone_weight_ii(stones: Vec<i32>) -> i32 {
        let sum: i32 = stones.iter().sum();
        let target = sum / 2;
        let mut dp = vec![false; (target + 1) as usize];
        dp[0] = true;
        for stone in stones {
            for j in (stone..=target).rev() {
                dp[j as usize] = dp[j as usize] || dp[(j - stone) as usize];
            }
        }
        for j in (0..=target).rev() {
            if dp[j as usize] {
                return sum - 2 * j;
            }
        }
        0
    }
}