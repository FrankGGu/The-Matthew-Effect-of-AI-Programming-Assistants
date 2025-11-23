pub fn can_complete_tasks(tasks: Vec<i32>, n: i32, power: i32) -> bool {
    let mut total_power = power;
    let mut remaining_tasks = tasks.clone();
    remaining_tasks.sort_unstable();

    for i in (0..remaining_tasks.len()).rev() {
        if total_power < remaining_tasks[i] {
            return false;
        }
        total_power -= remaining_tasks[i];
        if i > 0 {
            total_power += n;
        }
    }
    true
}