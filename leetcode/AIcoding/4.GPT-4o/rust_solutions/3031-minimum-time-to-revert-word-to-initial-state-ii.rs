pub fn minimum_time_to_revert(s: String, time: Vec<i32>) -> i32 {
    let n = s.len();
    let mut dp = vec![0; n + 1];

    for i in 0..n {
        dp[i + 1] = dp[i] + time[i];
        for j in 0..i {
            if s.chars().nth(i) == s.chars().nth(j) {
                dp[i + 1] = dp[i + 1].min(dp[j] + time[i]);
            }
        }
    }

    dp[n]
}