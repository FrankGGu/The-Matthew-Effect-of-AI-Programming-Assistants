impl Solution {
    pub fn integer_break(n: i32) -> i32 {
        if n <= 3 {
            return n - 1;
        }
        let mut dp = vec![0; (n + 1) as usize];
        dp[1] = 1;
        dp[2] = 2;
        dp[3] = 3;
        for i in 4..=n {
            for j in 1..i {
                dp[i as usize] = dp[i as usize].max(j * dp[(i - j) as usize]).max(j * (i - j));
            }
        }
        dp[n as usize]
    }
}