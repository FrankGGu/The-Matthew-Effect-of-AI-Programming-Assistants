impl Solution {
    pub fn winner_square_game(n: i32) -> bool {
        let n = n as usize;
        let mut dp = vec![false; n + 1];

        for i in 1..=n {
            let mut j = 1;
            while j * j <= i {
                if !dp[i - j * j] {
                    dp[i] = true;
                    break;
                }
                j += 1;
            }
        }

        dp[n]
    }
}