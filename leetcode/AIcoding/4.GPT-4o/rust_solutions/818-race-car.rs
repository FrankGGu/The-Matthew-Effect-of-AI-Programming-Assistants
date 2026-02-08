impl Solution {
    pub fn racecar(target: i32) -> i32 {
        let mut dp = vec![std::i32::MAX; (target + 1) as usize];
        dp[0] = 0;

        for t in 1..=target {
            let mut k = 1;
            while (1 << k) - 1 < t {
                let pos = (1 << k) - 1;
                dp[t as usize] = dp[t as usize].min(k + dp[(pos - t).abs() as usize] + 1);
                k += 1;
            }
            dp[t as usize] = dp[t as usize].min(k + (k - 1) - (pos - t).abs() + 1);
        }

        dp[target as usize]
    }
}