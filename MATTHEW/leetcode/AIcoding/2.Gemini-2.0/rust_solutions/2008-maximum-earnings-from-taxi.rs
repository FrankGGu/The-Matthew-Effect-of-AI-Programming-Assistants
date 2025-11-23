impl Solution {
    pub fn max_taxi_earnings(n: i32, rides: Vec<Vec<i32>>) -> i64 {
        let mut rides = rides;
        rides.sort_by_key(|ride| ride[1]);
        let mut dp = vec![0; rides.len() + 1];
        for i in 1..=rides.len() {
            let (start, end, tip) = (rides[i - 1][0], rides[i - 1][1], rides[i - 1][2]);
            let current_earning = (end - start + tip) as i64;
            let mut j = i - 1;
            while j > 0 && rides[j - 1][1] > start {
                j -= 1;
            }
            dp[i] = dp[i - 1].max(dp[j] + current_earning);
        }
        dp[rides.len()]
    }
}