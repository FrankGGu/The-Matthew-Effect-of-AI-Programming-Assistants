impl Solution {
    pub fn num_music_playlists(n: i32, m: i32, k: i32) -> i32 {
        const MOD: i32 = 1_000_000_007;
        let mut dp = vec![vec![0; (m + 1) as usize]; (n + 1) as usize];
        dp[0][0] = 1;

        for i in 1..=n {
            for j in 1..=m {
                dp[i as usize][j as usize] = dp[i as usize][j as usize] * (i - k).max(0) % MOD; // Adding a new song
                if j > 1 {
                    dp[i as usize][j as usize] = (dp[i as usize][j as usize] + dp[i as usize][j - 1] * (n - i + 1)) % MOD; // Replaying an old song
                }
            }
        }

        dp[n as usize][m as usize]
    }
}