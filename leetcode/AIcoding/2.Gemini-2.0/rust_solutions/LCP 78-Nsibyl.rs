impl Solution {
    pub fn build_wall(height: i32, width: i32, bricks: Vec<i32>) -> i32 {
        let mut dp = vec![0; width as usize];
        dp[0] = 1;

        for brick in bricks {
            let brick = brick as usize;
            for i in 0..width as usize {
                if dp[i] > 0 {
                    if i + brick < width as usize {
                        dp[i + brick] = (dp[i + brick] + dp[i]) % 1000000007;
                    }
                }
            }
            dp[0] = 1;
            for i in 1..width as usize {
                dp[i] %= 1000000007;
            }

        }

        dp[width as usize - 1]
    }
}