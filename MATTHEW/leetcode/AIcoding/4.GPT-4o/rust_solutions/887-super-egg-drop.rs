impl Solution {
    pub fn super_egg_drop(k: i32, n: i32) -> i32 {
        let mut dp = vec![vec![0; (n + 1) as usize]; (k + 1) as usize];
        let mut moves = 0;

        while dp[k as usize][moves as usize] < n {
            moves += 1;
            for i in 1..=k {
                dp[i as usize][moves as usize] = dp[i as usize][moves - 1] + dp[i as usize - 1][moves - 1] + 1;
            }
        }

        moves
    }
}