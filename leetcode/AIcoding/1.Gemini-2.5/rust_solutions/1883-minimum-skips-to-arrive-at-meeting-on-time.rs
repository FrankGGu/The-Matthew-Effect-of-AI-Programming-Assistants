struct Solution;
impl Solution {
    pub fn min_skips(distances: Vec<i32>, speed: i32, hours: i32) -> i32 {
        let n = distances.len();

        let mut dp = vec![f64::INFINITY; n + 1];
        dp[0] = 0.0;

        for i in 1..=n {
            let travel_time_for_current_segment = distances[i - 1] as f64 / speed as f64;

            let mut next_dp = vec![f64::INFINITY; n + 1];

            for j in 0..=i {
                // Option 1: Do NOT skip at the (i-1)-th city (before current segment).
                // This means `j` skips were already used for the first `i-1` segments.
                if dp[j] != f64::INFINITY {
                    let time_before_current_segment = dp[j];
                    let departure_time = time_before_current_segment.ceil();
                    next_dp[j] = next_dp[j].min(departure_time + travel_time_for_current_segment);
                }

                // Option 2: DO skip at the (i-1)-th city (before current segment).
                // This means `j-1` skips were used for the first `i-1` segments,
                // and the current skip is the `j`-th skip.
                if j > 0 && dp[j - 1] != f64::INFINITY {
                    let time_before_current_segment = dp[j - 1];
                    next_dp[j] = next_dp[j].min(time_before_current_segment + travel_time_for_current_segment);
                }
            }
            dp = next_dp;
        }

        for j in 0..=n {
            if dp[j] <= hours as f64 {
                return j as i32;
            }
        }

        -1
    }
}