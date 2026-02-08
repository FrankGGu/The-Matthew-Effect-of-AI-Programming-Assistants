impl Solution {
    pub fn find_kth_smallest_amount(coins: Vec<i32>, k: i32) -> i32 {
        let max_amount = coins.iter().max().unwrap();
        let mut dp = vec![false; (k + 1) as usize];
        dp[0] = true;

        for &coin in &coins {
            for j in (coin..=k).rev() {
                dp[j as usize] |= dp[(j - coin) as usize];
            }
        }

        (0..=k).find(|&x| dp[x as usize]).unwrap_or(-1)
    }
}