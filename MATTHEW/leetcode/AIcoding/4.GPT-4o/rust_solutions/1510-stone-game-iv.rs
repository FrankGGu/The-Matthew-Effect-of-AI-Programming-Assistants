impl Solution {
    pub fn winner_square_game(n: i32) -> bool {
        let mut dp = vec![false; (n + 1) as usize];
        for i in 1..=n {
            let mut j = 1;
            while j * j <= i {
                if !dp[(i - j * j) as usize] {
                    dp[i as usize] = true;
                    break;
                }
                j += 1;
            }
        }
        dp[n as usize]
    }
}