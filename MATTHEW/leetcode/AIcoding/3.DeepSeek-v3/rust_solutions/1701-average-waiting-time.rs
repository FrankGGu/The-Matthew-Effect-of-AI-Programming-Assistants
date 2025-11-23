impl Solution {
    pub fn average_waiting_time(customers: Vec<Vec<i32>>) -> f64 {
        let mut total_waiting_time = 0;
        let mut current_time = 0;

        for customer in customers {
            let arrival = customer[0];
            let time_needed = customer[1];

            current_time = current_time.max(arrival) + time_needed;
            total_waiting_time += current_time - arrival;
        }

        total_waiting_time as f64 / customers.len() as f64
    }
}