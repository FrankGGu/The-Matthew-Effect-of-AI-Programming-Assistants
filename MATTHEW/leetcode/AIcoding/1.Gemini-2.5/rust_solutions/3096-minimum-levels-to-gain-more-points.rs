impl Solution {
    pub fn minimum_levels(coins: Vec<i32>) -> i32 {
        let n = coins.len();
        let mut current_prefix_score: i32 = 0;
        let mut total_remaining_score: i32 = 0;

        for &coin in coins.iter() {
            total_remaining_score += coin.max(0);
        }

        for i in 0..n - 1 {
            current_prefix_score += coins[i];
            total_remaining_score -= coins[i].max(0);

            if current_prefix_score > total_remaining_score {
                return (i + 1) as i32;
            }
        }

        unreachable!();
    }
}