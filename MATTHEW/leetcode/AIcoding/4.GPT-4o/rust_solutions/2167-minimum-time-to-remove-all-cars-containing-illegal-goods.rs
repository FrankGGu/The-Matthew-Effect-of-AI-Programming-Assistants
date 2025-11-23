impl Solution {
    pub fn minimum_time_to_remove_cars(cars: Vec<i32>) -> i32 {
        let n = cars.len();
        let mut dp = vec![0; n + 1];

        for i in 1..=n {
            dp[i] = dp[i - 1] + cars[i - 1];
            if i > 1 {
                dp[i] = dp[i].min(dp[i - 2] + cars[i - 1] + cars[i - 2]);
            }
        }

        dp[n]
    }
}