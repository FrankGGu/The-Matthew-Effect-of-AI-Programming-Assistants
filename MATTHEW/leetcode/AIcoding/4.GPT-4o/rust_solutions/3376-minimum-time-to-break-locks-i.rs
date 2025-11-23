pub fn min_time_to_break_locks(locks: Vec<i32>, time: i32) -> i32 {
    let mut total_time = 0;
    for &lock in &locks {
        total_time += (lock + time - 1) / time;
    }
    total_time
}