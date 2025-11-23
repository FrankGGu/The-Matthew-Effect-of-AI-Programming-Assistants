impl Solution {
    pub fn max_value_of_coins(piles: Vec<Vec<i32>>, k: i32) -> i32 {
        let k = k as usize;
        let mut dp = vec![0; k + 1];

        for pile in piles {
            let mut current_dp = dp.clone();
            let mut sum = 0;

            for (i, &coin) in pile.iter().enumerate().take(k) {
                sum += coin;
                for j in 0..=(k - i - 1) {
                    if dp[j] + sum > current_dp[j + i + 1] {
                        current_dp[j + i + 1] = dp[j] + sum;
                    }
                }
            }

            dp = current_dp;
        }

        dp[k]
    }
}