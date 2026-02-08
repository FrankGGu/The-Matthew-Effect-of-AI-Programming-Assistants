impl Solution {
    pub fn max_color_combinations(colors: Vec<i32>) -> i32 {
        let n = colors.len();
        let mut dp = vec![0; n + 1];
        dp[0] = 1;

        for i in 1..=n {
            for j in 0..i {
                if colors[j] != colors[i - 1] {
                    dp[i] = (dp[i] + dp[j]) % 1000000007;
                }
            }
        }

        dp[n]
    }
}