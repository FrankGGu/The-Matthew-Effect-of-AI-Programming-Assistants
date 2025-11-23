pub fn calculate_delayed_arrival_time(t: i32, d: i32) -> i32 {
    (t + d) % 24
}