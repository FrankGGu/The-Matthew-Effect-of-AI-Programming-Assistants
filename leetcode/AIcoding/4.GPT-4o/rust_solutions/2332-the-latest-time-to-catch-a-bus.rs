use std::collections::HashSet;

pub fn latest_time_to_catch_bus(buses: Vec<i32>, passengers: Vec<i32>, capacity: i32) -> i32 {
    let mut buses = buses;
    buses.sort();
    let mut passengers = passengers;
    passengers.sort();

    let mut p_index = 0;
    let mut bus_times = HashSet::new();

    for &bus in &buses {
        let mut count = 0;
        while p_index < passengers.len() && passengers[p_index] <= bus && count < capacity {
            count += 1;
            p_index += 1;
        }
        bus_times.insert(bus);
    }

    let mut last_time = -1;
    for &bus in buses.iter().rev() {
        let mut count = 0;
        let mut current_time = bus;

        while p_index > 0 && passengers[p_index - 1] >= bus - 1 && count < capacity {
            current_time = passengers[p_index - 1] - 1;
            p_index -= 1;
            count += 1;
        }

        last_time = current_time;
        if !bus_times.contains(&last_time) {
            break;
        }
    }

    last_time
}