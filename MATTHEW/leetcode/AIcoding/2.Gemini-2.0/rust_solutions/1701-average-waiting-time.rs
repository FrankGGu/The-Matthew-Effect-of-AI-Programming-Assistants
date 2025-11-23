impl Solution {
    pub fn average_waiting_time(customers: Vec<Vec<i32>>) -> f64 {
        let mut current_time = 0;
        let mut total_waiting_time = 0;
        for customer in &customers {
            let arrival_time = customer[0];
            let service_time = customer[1];
            if current_time <= arrival_time {
                current_time = arrival_time + service_time;
                total_waiting_time += service_time as i64;
            } else {
                let waiting_time = current_time - arrival_time;
                current_time += service_time;
                total_waiting_time += waiting_time as i64 + service_time as i64;
            }
        }
        total_waiting_time as f64 / customers.len() as f64
    }
}