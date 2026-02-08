pub fn max_two_events(events: Vec<Vec<i32>>) -> i32 {
    let mut events = events;
    events.sort_by_key(|event| event[1]);
    let n = events.len();

    let mut dp = vec![0; n];
    let mut max_value = 0;

    for i in 0..n {
        dp[i] = events[i][2];
        for j in 0..i {
            if events[j][1] < events[i][0] {
                dp[i] = dp[i].max(dp[j] + events[i][2]);
            }
        }
        max_value = max_value.max(dp[i]);
    }

    max_value
}