pub fn ant_meet(position_a: i32, time_a: i32, position_b: i32, time_b: i32) -> f64 {
    let total_a = position_a + time_a;
    let total_b = position_b - time_b;
    if total_a < total_b {
        total_a as f64
    } else if total_a > total_b {
        total_b as f64
    } else {
        total_a as f64
    }
}