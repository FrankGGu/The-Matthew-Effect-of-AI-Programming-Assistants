impl Solution {
    pub fn people_aware_of_secret(n: i32, delay: i32, forget: i32) -> i32 {
        let n = n as usize;
        let delay = delay as usize;
        let forget = forget as usize;
        let modulo = 1_000_000_007;
        let mut dp = vec![0; n + 1];
        dp[1] = 1;
        for i in 2..=n {
            let start = if i >= forget { i - forget } else { 0 };
            let end = i - delay;
            for j in start..end {
                if j >= 1 {
                    dp[i] = (dp[i] + dp[j]) % modulo;
                }
            }
        }
        let mut res = 0;
        for i in (n.saturating_sub(forget - 1)..=n {
            res = (res + dp[i]) % modulo;
        }
        res
    }
}