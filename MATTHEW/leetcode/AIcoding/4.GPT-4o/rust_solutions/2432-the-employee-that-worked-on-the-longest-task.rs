use std::collections::HashMap;

pub fn hardest_worker(n: i32, logs: Vec<Vec<i32>>) -> i32 {
    let mut max_time = 0;
    let mut employee_id = 0;
    let mut previous_time = 0;

    for log in logs {
        let (id, time) = (log[0], log[1]);
        let worked_time = time - previous_time;
        previous_time = time;

        if worked_time > max_time || (worked_time == max_time && id > employee_id) {
            max_time = worked_time;
            employee_id = id;
        }
    }

    employee_id
}