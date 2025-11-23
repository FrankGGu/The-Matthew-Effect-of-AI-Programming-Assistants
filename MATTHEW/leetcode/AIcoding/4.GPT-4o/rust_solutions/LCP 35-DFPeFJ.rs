pub fn can_reach_destination(distance: i32, battery: Vec<i32>, charge: Vec<i32>) -> bool {
    let n = battery.len();
    let mut dp = vec![0; n + 1];
    dp[0] = 0;

    for i in 0..n {
        for j in (1..=i + 1).rev() {
            dp[j] = dp[j].max(dp[j - 1] + battery[i]);
        }
        for j in (1..=i + 1).rev() {
            dp[j] = dp[j].max(dp[j] + charge[i]);
        }
    }

    dp.iter().any(|&x| x >= distance)
}