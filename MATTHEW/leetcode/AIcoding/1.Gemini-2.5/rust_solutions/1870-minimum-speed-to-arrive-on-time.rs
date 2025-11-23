impl Solution {
    pub fn min_speed_on_time(dist: Vec<i32>, hour: f64) -> i32 {
        let n = dist.len();

        // If n > 1, the minimum time for the first n-1 trains, even with infinite speed,
        // is (n-1) hours (since ceil(dist[i]/s) becomes 1 for large s).
        // The last train dist[n-1] also takes time dist[n-1]/s, which is strictly positive
        // since dist[i] >= 1.
        // Therefore, the total time is always strictly greater than (n-1).
        // If hour is less than or equal to (n-1) as f64, it's impossible to arrive on time.
        if n > 1 && hour <= (n - 1) as f64 {
            return -1;
        }

        let mut low: u64 = 1;
        // The maximum possible speed.
        // Given that 'hour' has at most two digits after the decimal point,
        // the smallest positive fractional part of (hour - (n-1)) would be 0.01.
        // In the worst case, if (hour - (n-1)) is 0.01 and dist[n-1] is 10^5,
        // then speed 's' could be approximately 10^5 / 0.01 = 10^7.
        // An upper bound of 10^9 (which fits in i32) is safe for binary search.
        let mut high: u64 = 1_000_000_000; 
        let mut ans: i32 = -1;

        while low <= high {
            let mid = low + (high - low) / 2;

            let mut current_time: f64 = 0.0;
            for i in 0..n - 1 {
                // For all trains except the last, time is rounded up to the nearest integer hour.
                current_time += (dist[i] as f64 / mid as f64).ceil();
            }
            // The last train's time is not rounded up.
            current_time += dist[n - 1] as f64 / mid as f64;

            // Check if this speed allows arriving on time.
            if current_time <= hour {
                ans = mid as i32; // mid will fit in i32 due to the high bound
                high = mid - 1;   // Try to find a smaller speed
            } else {
                low = mid + 1;    // Need a faster speed
            }
        }

        ans
    }
}