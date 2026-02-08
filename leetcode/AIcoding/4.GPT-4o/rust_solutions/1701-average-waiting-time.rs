impl Solution {
    pub fn average_waiting_time(customers: Vec<Vec<i32>>) -> f64 {
        let mut total_time = 0;
        let mut current_time = 0;

        for customer in customers {
            let arrival = customer[0];
            let time_needed = customer[1];
            if current_time < arrival {
                current_time = arrival;
            }
            current_time += time_needed;
            total_time += current_time - arrival;
        }

        total_time as f64 / customers.len() as f64
    }
}