impl Solution {
    pub fn minimum_operations(x: i32, y: i32) -> i32 {
        if x <= y {
            return y - x;
        }

        let mut dp = vec![0; (x + 201) as usize];
        for i in (y as usize..=x as usize).rev() {
            dp[i] = (i - y as usize) as i32;
        }

        for i in (y as usize..x as usize).rev() {
            dp[i] = dp[i + 1] + 1;
            dp[i] = dp[i].min(dp[i + 5] + 1);
            dp[i] = dp[i].min(dp[i - 5] + 1);
        }

        dp[x as usize]
    }
}