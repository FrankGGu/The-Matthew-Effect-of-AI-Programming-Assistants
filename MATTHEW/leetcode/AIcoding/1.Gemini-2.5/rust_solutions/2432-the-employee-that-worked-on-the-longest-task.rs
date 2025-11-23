impl Solution {
    pub fn longest_task_employee(n: i32, logs: Vec<Vec<i32>>) -> i32 {
        let mut max_duration = 0;
        let mut result_employee_id = 0;
        let mut prev_end_time = 0;

        for log in logs {
            let employee_id = log[0];
            let current_end_time = log[1];

            let current_duration = current_end_time - prev_end_time;

            if current_duration > max_duration {
                max_duration = current_duration;
                result_employee_id = employee_id;
            } else if current_duration == max_duration {
                result_employee_id = result_employee_id.min(employee_id);
            }

            prev_end_time = current_end_time;
        }

        result_employee_id
    }
}