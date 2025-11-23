impl Solution {
    pub fn latest_time_catch_the_bus(buses: Vec<i32>, passengers: Vec<i32>, capacity: i32) -> i32 {
        let mut buses = buses;
        let mut passengers = passengers;
        buses.sort();
        passengers.sort();

        let mut j = 0;
        let mut last_bus_time = 0;
        let mut count = 0;

        for &bus_time in &buses {
            count = 0;
            while j < passengers.len() && passengers[j] <= bus_time && count < capacity {
                j += 1;
                count += 1;
            }
            last_bus_time = bus_time;
        }

        let mut ans = if count < capacity {
            last_bus_time
        } else {
            passengers[j - 1] - 1
        };

        while passengers.contains(&ans) {
            ans -= 1;
        }

        ans
    }
}