impl Solution {
    pub fn latest_time_to_catch_a_bus(mut buses: Vec<i32>, mut passengers: Vec<i32>, capacity: i32) -> i32 {
        buses.sort_unstable();
        passengers.sort_unstable();

        let mut p_ptr = 0;
        let mut initial_latest_time = 0;

        for (bus_idx, &b_time) in buses.iter().enumerate() {
            let mut current_bus_capacity_used = 0;
            let is_last_bus = bus_idx == buses.len() - 1;

            while p_ptr < passengers.len() && passengers[p_ptr] <= b_time && current_bus_capacity_used < capacity {
                p_ptr += 1;
                current_bus_capacity_used += 1;
            }

            if is_last_bus {
                if current_bus_capacity_used < capacity {
                    // The last bus is not full. The new passenger can arrive at the bus's departure time.
                    initial_latest_time = b_time;
                } else {
                    // The last bus is full. The new passenger must arrive before the last boarded passenger.
                    // p_ptr points to the first passenger *not* boarded on this bus (or end of passengers).
                    // So passengers[p_ptr - 1] is the last passenger boarded on this bus.
                    initial_latest_time = passengers[p_ptr - 1] - 1;
                }
            }
        }

        // Now, adjust initial_latest_time to find the largest time t <= initial_latest_time
        // such that t is not an existing passenger's arrival time.
        let mut result_time = initial_latest_time;

        // Find the index of `result_time` in `passengers` using binary search.
        // If `result_time` is in `passengers`, `Ok(idx)` is returned.
        // If `result_time` is not in `passengers`, `Err(idx)` is returned, where `idx` is the insertion point.
        match passengers.binary_search(&result_time) {
            Ok(mut idx) => {
                // result_time is an existing passenger's arrival time.
                // We need to find the largest time less than result_time that is not in passengers.
                result_time -= 1; // Try the time just before this passenger

                // Move to the passenger before this one.
                // We need to handle potential underflow if idx is 0.
                if idx > 0 {
                    idx -= 1; 
                } else {
                    // If idx was 0, and result_time is 0, then we are looking for -1.
                    // The loop condition idx >= 0 will immediately be false.
                    // This is handled correctly.
                    idx = -1; // Indicate that there are no more passengers to check backwards
                }

                // Keep decrementing result_time and idx as long as we hit existing passengers
                while idx >= 0 && passengers[idx as usize] == result_time {
                    result_time -= 1;
                    idx -= 1;
                }
            },
            Err(_) => {
                // result_time is not an existing passenger's arrival time.
                // This is already the latest possible unique time. No adjustment needed.
            }
        }

        result_time
    }
}