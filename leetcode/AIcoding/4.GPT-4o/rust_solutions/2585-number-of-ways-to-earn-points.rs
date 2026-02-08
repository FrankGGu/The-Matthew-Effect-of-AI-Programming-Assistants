impl Solution {
    pub fn ways_to_earn_points(points: Vec<i32>, target: i32) -> i32 {
        let mod_val = 1_000_000_007;
        let n = points.len();
        let mut dp = vec![0; target as usize + 1];
        dp[0] = 1;

        for &point in &points {
            for j in (point as usize..=target as usize).rev() {
                dp[j] = (dp[j] + dp[j - point as usize]) % mod_val;
            }
        }

        dp[target as usize]
    }
}