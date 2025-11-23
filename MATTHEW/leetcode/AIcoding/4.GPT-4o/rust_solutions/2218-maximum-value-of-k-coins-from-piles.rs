impl Solution {
    pub fn max_value_of_coins(piles: Vec<Vec<i32>>, k: i32) -> i32 {
        let n = piles.len();
        let k = k as usize;
        let mut dp = vec![0; k + 1];

        for pile in piles {
            let m = pile.len();
            let mut prefix_sum = vec![0; m + 1];
            for j in 0..m {
                prefix_sum[j + 1] = prefix_sum[j] + pile[j];
            }
            for j in (0..=k).rev() {
                for x in 1..=m.min(j) {
                    dp[j] = dp[j].max(dp[j - x] + prefix_sum[x]);
                }
            }
        }

        dp[k]
    }
}