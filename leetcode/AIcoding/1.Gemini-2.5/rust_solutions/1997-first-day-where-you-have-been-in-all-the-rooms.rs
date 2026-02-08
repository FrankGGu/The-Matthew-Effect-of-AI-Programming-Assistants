impl Solution {
    pub fn first_day_where_you_have_been_in_all_rooms(next_visit: Vec<i32>) -> i32 {
        let n = next_visit.len();
        let modulo = 1_000_000_007;

        // dp[i] represents the day we first arrive at room i.
        // When we arrive at room i for the first time, it means we have
        // completed an even number of visits for all rooms 0, ..., i-1,
        // and then moved to room i. At this point, room i is visited for the first time.
        let mut dp: Vec<i64> = vec![0; n];

        // Base case: We start at room 0 on day 0.
        // So, the day we arrive at room 0 is 0.
        dp[0] = 0;

        // Iterate from room 1 to n-1 to fill the dp array
        for i in 1..n {
            // To arrive at room i for the first time:
            // 1. We must have arrived at room i-1 on day dp[i-1]. This is the 1st visit to i-1 (odd).
            // 2. From room i-1 (after its odd visit), we move to nextVisit[i-1]. This takes 1 day.
            //    The current day is dp[i-1] + 1. We are now at room nextVisit[i-1].
            // 3. From room nextVisit[i-1], we need to return to room i-1.
            //    The number of days to go from room nextVisit[i-1] to room i-1 (after nextVisit[i-1]
            //    has been visited an odd number of times, and then completing even visits for
            //    nextVisit[i-1] through i-2, and finally arriving at i-1 for its 2nd visit)
            //    is given by the time difference: dp[i-1] - dp[nextVisit[i-1]].
            //    So, the day we arrive at room i-1 for the 2nd time (even visit) is:
            //    (dp[i-1] + 1) + (dp[i-1] - dp[nextVisit[i-1]]).
            // 4. After visiting room i-1 an even number of times, we move to room i. This takes 1 day.
            //    Therefore, the day we arrive at room i (dp[i]) is:
            //    dp[i] = (dp[i-1] + 1) + (dp[i-1] - dp[next_visit[i-1] as usize]) + 1
            //    dp[i] = 2 * dp[i-1] - dp[next_visit[i-1] as usize] + 2

            let prev_room_day = dp[i - 1];
            let next_visit_target_room_idx = next_visit[i - 1] as usize;
            let next_visit_target_room_day = dp[next_visit_target_room_idx];

            let mut current_day = (2 * prev_room_day - next_visit_target_room_day + 2) % modulo;

            // Ensure the result is non-negative, as modulo in Rust can return negative for negative inputs
            if current_day < 0 {
                current_day += modulo;
            }

            dp[i] = current_day;
        }

        // The problem asks for the first day where all rooms have been visited.
        // When we arrive at room n-1 (on day dp[n-1]), all rooms 0, ..., n-1 have been visited
        // at least once. Thus, dp[n-1] is the answer.
        dp[n - 1] as i32
    }
}