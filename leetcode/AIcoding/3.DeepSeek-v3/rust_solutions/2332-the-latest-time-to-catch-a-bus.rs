impl Solution {
    pub fn latest_time_catch_the_bus(buses: Vec<i32>, passengers: Vec<i32>, capacity: i32) -> i32 {
        let mut buses = buses;
        let mut passengers = passengers;
        buses.sort_unstable();
        passengers.sort_unstable();

        let mut i = 0;
        let mut latest_time = 0;

        for &bus_time in &buses {
            let mut current_capacity = 0;
            while i < passengers.len() && passengers[i] <= bus_time && current_capacity < capacity {
                if i == 0 || passengers[i] - 1 > passengers[i - 1] {
                    latest_time = passengers[i] - 1;
                }
                i += 1;
                current_capacity += 1;
            }
            if current_capacity < capacity && (i == 0 || passengers[i - 1] != bus_time) {
                latest_time = bus_time;
            }
        }

        latest_time
    }
}