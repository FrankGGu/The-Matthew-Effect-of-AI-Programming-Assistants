impl Solution {
    pub fn car_pooling(trips: Vec<Vec<i32>>, capacity: i32) -> bool {
        // The maximum end_location is 1000.
        // If a trip ends at location `L`, passengers are on board at `L`.
        // They get off *after* `L`, meaning the car capacity is freed starting from `L + 1`.
        // So, we need to track changes up to `max_end_location + 1`.
        // `max_end_location` is 1000, so `max_end_location + 1` is 1001.
        // An array of size 1002 will cover indices 0 to 1001.
        let mut passenger_changes = vec![0; 1002];

        for trip in trips {
            let num_passengers = trip[0];
            let start_location = trip[1] as usize;
            let end_location = trip[2] as usize; // Passengers are on board AT this destination

            // Passengers get on at start_location
            passenger_changes[start_location] += num_passengers;
            // Passengers get off *after* end_location.
            // So, the car's capacity is freed from end_location + 1.
            passenger_changes[end_location + 1] -= num_passengers;
        }

        let mut current_passengers = 0;
        // Iterate through all possible locations to simulate the car's journey.
        // The loop goes up to the maximum index that might have a change (1001).
        for i in 0..passenger_changes.len() {
            current_passengers += passenger_changes[i];
            if current_passengers > capacity {
                return false;
            }
        }

        true
    }
}