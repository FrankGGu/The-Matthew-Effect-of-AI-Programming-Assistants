impl Solution {
    pub fn new21_game(n: i32, k: i32, max_pts: i32) -> f64 {
        if k == 0 || n >= k - 1 + max_pts {
            return 1.0;
        }

        let n = n as usize;
        let k = k as usize;
        let max_pts = max_pts as usize;

        let mut dp = vec![0.0; n + 1];
        dp[0] = 1.0;

        let mut current_prob_sum = 1.0;
        let mut ans = 0.0;

        for i in 1..=n {
            dp[i] = current_prob_sum / (max_pts as f64);

            if i >= k {
                ans += dp[i];
            } else {
                current_prob_sum += dp[i];
            }

            if i >= max_pts {
                if i - max_pts < k {
                    current_prob_sum -= dp[i - max_pts];
                }
            }
        }

        ans
    }
}