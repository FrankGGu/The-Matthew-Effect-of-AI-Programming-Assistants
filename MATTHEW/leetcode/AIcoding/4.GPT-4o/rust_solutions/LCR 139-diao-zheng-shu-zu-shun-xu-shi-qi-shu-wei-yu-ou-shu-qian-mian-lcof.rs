pub fn can_complete_plan(plan: Vec<i32>, time: i32) -> bool {
    let mut total_time = 0;
    for &t in &plan {
        total_time += t;
    }
    total_time <= time
}