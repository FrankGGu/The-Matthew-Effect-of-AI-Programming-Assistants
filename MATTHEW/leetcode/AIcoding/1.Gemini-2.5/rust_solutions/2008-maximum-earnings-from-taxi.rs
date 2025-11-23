impl Solution {
    pub fn max_taxi_earnings(n: i32, rides: Vec<Vec<i32>>) -> i64 {
        let mut processed_rides: Vec<(i32, i32, i64)> = rides
            .into_iter()
            .map(|ride| {
                let start = ride[0];
                let end = ride[1];
                let tip = ride[2];
                (start, end, (end - start + tip) as i64)
            })
            .collect();

        processed_rides.sort_unstable_by_key(|r| (r.1, r.0));

        let num_rides = processed_rides.len();
        let mut dp: Vec<i64> = vec![0; num_rides + 1];

        for i in 0..num_rides {
            let (current_start, _, current_earnings) = processed_rides[i];

            let max_earnings_without_current = dp[i];

            let mut low = 0;
            let mut high = i as i32 - 1;
            let mut prev_ride_dp_index = 0; 

            while low <= high {
                let mid = low + (high - low) / 2;
                if processed_rides[mid as usize].1 <= current_start {
                    prev_ride_dp_index = (mid + 1) as usize; 
                    low = mid + 1;
                } else {
                    high = mid - 1;
                }
            }

            let max_earnings_with_current = current_earnings + dp[prev_ride_dp_index];

            dp[i + 1] = max_earnings_without_current.max(max_earnings_with_current);
        }

        dp[num_rides]
    }
}