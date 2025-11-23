impl Solution {
    pub fn number_of_ways(start_pos: i32, end_pos: i32, k: i32) -> i32 {
        let diff = (end_pos - start_pos).abs();
        if (k - diff) % 2 != 0 || diff > k {
            return 0;
        }
        let n = ((k - diff) / 2 + diff) as usize;
        let m = diff as usize;
        let mod_num = 1_000_000_007;
        let mut dp = vec![vec![0; n + 1]; n + 1];
        for i in 0..=n {
            dp[i][0] = 1;
            for j in 1..=i {
                dp[i][j] = (dp[i - 1][j - 1] + dp[i - 1][j]) % mod_num;
            }
        }
        dp[n][m] as i32
    }
}