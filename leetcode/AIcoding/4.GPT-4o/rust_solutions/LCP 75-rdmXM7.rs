impl Solution {
    pub fn min_steps_to_exit(rolls: Vec<i32>, k: i32) -> i32 {
        let n = rolls.len();
        let mut dp = vec![i32::MAX; n + 1];
        dp[0] = 0;

        for i in 0..n {
            for j in 1..=k.min(n - i as i32) {
                dp[(i + j) as usize] = dp[(i + j) as usize].min(dp[i] + 1);
            }
        }

        if dp[n] == i32::MAX { -1 } else { dp[n] }
    }
}