impl Solution {
    pub fn max_taxi_earnings(n: i32, rides: Vec<Vec<i32>>) -> i64 {
        let n = n as usize;
        let mut rides = rides;
        rides.sort_unstable_by_key(|r| r[1]);
        let mut dp = vec![0; n + 1];
        let mut j = 0;
        for i in 1..=n {
            dp[i] = dp[i - 1];
            while j < rides.len() && rides[j][1] as usize == i {
                let start = rides[j][0] as usize;
                let end = rides[j][1] as usize;
                let tip = rides[j][2] as i64;
                let total = (end - start) as i64 + tip;
                dp[i] = dp[i].max(dp[start] + total);
                j += 1;
            }
        }
        dp[n]
    }
}