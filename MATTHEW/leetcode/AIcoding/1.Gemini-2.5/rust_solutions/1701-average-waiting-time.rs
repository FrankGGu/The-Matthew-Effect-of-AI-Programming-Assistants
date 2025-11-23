impl Solution {
    pub fn average_waiting_time(customers: Vec<Vec<i32>>) -> f64 {
        let mut total_waiting_time: f64 = 0.0;
        let mut current_chef_available_time: f64 = 0.0;

        for customer in customers.iter() {
            let arrival_time = customer[0] as f64;
            let prep_time = customer[1] as f64;

            let start_preparation_time = current_chef_available_time.max(arrival_time);
            let finish_time = start_preparation_time + prep_time;
            let waiting_time = finish_time - arrival_time;

            total_waiting_time += waiting_time;
            current_chef_available_time = finish_time;
        }

        total_waiting_time / (customers.len() as f64)
    }
}