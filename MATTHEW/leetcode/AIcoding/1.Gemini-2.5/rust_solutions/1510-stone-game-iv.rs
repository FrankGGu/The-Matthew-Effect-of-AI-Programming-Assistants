impl Solution {
    pub fn winner_square_game(n: i32) -> bool {
        let n = n as usize;
        let mut dp = vec![false; n + 1];

        for i in 1..=n {
            let mut k = 1;
            while k * k <= i {
                if !dp[i - k * k] {
                    dp[i] = true;
                    break;
                }
                k += 1;
            }
        }

        dp[n]
    }
}