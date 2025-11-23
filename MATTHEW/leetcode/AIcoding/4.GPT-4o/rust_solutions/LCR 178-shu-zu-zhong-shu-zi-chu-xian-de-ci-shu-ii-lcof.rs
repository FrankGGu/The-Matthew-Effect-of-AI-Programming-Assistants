pub fn can_complete(tasks: Vec<i32>, hours: i32) -> bool {
    let total_hours: i32 = tasks.iter().sum();
    total_hours <= hours
}