impl Solution {
    pub fn max_value_of_coins(piles: Vec<Vec<i32>>, k: i32) -> i32 {
        let k_usize = k as usize;
        let mut dp = vec![0; k_usize + 1];

        for pile in piles {
            let mut current_pile_prefix_sums = Vec::new();
            let mut p_sum = 0;
            for &coin_val in &pile {
                p_sum += coin_val;
                current_pile_prefix_sums.push(p_sum);
            }

            for j in (0..=k_usize).rev() {
                for c in 1..=pile.len() {
                    if j >= c {
                        let value_from_current_pile = current_pile_prefix_sums[c - 1];
                        dp[j] = dp[j].max(dp[j - c] + value_from_current_pile);
                    } else {
                        break;
                    }
                }
            }
        }

        dp[k_usize]
    }
}