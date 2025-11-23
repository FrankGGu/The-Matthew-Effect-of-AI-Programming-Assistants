impl Solution {
    pub fn new21_game(n: i32, k: i32, max_pts: i32) -> f64 {
        let (n, k, max_pts) = (n as usize, k as usize, max_pts as usize);
        if k == 0 || n >= k + max_pts {
            return 1.0;
        }
        let mut dp = vec![0.0; n + 1];
        dp[0] = 1.0;
        let mut sum = 1.0;
        let mut res = 0.0;
        for i in 1..=n {
            dp[i] = sum / max_pts as f64;
            if i < k {
                sum += dp[i];
            } else {
                res += dp[i];
            }
            if i >= max_pts {
                sum -= dp[i - max_pts];
            }
        }
        res
    }
}