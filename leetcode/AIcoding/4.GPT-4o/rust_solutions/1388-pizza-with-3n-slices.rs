impl Solution {
    pub fn max_size_slices(slices: Vec<i32>, k: i32) -> i32 {
        let n = slices.len();
        let k = k as usize;
        let take = |start: usize, end: usize| {
            let mut dp = vec![0; k + 1];
            for i in start..end {
                for j in (1..=k).rev() {
                    dp[j] = dp[j].max(dp[j - 1] + slices[i]);
                }
            }
            dp[k]
        };
        take(0, n - n / 3).max(take(1, n - n / 3 + 1))
    }
}