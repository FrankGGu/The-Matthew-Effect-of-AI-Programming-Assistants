impl Solution {
    pub fn soup_servings(n: i32) -> f64 {
        if n > 5000 {
            return 1.0;
        }
        let n = (n + 24) / 25;
        let mut dp = vec![vec![0.0; n as usize + 1]; n as usize + 1];
        dp[0][0] = 0.5;

        for i in 0..=n as usize {
            for j in 0..=n as usize {
                if i == 0 && j == 0 {
                    continue;
                }
                let mut prob = 0.0;
                if i > 0 {
                    prob += dp[(i - 1).min(n as usize)][j] * 0.25;
                }
                if j > 0 {
                    prob += dp[i][(j - 1).min(n as usize)] * 0.25;
                }
                if i > 0 && j > 0 {
                    prob += dp[(i - 1).min(n as usize)][(j - 1).min(n as usize)] * 0.25;
                }
                dp[i][j] = prob;
            }
        }

        let mut result = 0.0;
        for i in 0..=n as usize {
            result += dp[i][0];
        }
        result
    }
}