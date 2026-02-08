impl Solution {
    pub fn ways_to_reach_stairs(n: i32, k: i32) -> i32 {
        let mut dp = vec![0; (n + 1) as usize];
        dp[0] = 1;

        for i in 1..=n {
            for j in 1..=k {
                if i - j >= 0 {
                    dp[i as usize] += dp[(i - j) as usize];
                }
            }
        }

        dp[n as usize]
    }
}