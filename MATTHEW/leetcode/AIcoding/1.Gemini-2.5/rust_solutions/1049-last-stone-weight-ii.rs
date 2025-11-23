impl Solution {
    pub fn last_stone_weight_ii(stones: Vec<i32>) -> i32 {
        let total_sum: i32 = stones.iter().sum();
        let target_sum = total_sum / 2;

        let mut dp = vec![false; (target_sum + 1) as usize];
        dp[0] = true;

        for &weight in stones.iter() {
            for j in (weight..=target_sum).rev() {
                if dp[(j - weight) as usize] {
                    dp[j as usize] = true;
                }
            }
        }

        let mut s1_max = 0;
        for j in (0..=target_sum).rev() {
            if dp[j as usize] {
                s1_max = j;
                break;
            }
        }

        total_sum - 2 * s1_max
    }
}