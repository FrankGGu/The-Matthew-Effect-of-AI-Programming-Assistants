impl Solution {
    pub fn max_running_time(n: i32, batteries: Vec<i32>) -> i64 {
        let check = |time: i64| -> bool {
            // If time is 0, it's always possible to run for 0 minutes.
            if time == 0 {
                return true;
            }

            let mut available_power = 0i64;
            for &b in batteries.iter() {
                // For each battery, it can contribute at most 'time' minutes
                // to one computer's primary requirement. Any excess power
                // (b - time) can be used to top up other computers.
                // The sum of min(battery_capacity, time) represents the total
                // effective power that can be distributed among the 'n' computers,
                // where each computer needs 'time' minutes.
                available_power += (b as i64).min(time);
            }
            // If the total available effective power is at least n * time,
            // then it's possible to run n computers for 'time' minutes each.
            available_power >= n as i64 * time
        };

        let mut low = 0i64;
        // The maximum possible running time for each computer is the total
        // sum of battery capacities divided by the number of computers.
        // This provides an upper bound for the binary search.
        let mut high = batteries.iter().map(|&x| x as i64).sum::<i64>() / n as i64;
        let mut ans = 0i64;

        while low <= high {
            let mid = low + (high - low) / 2;
            if check(mid) {
                ans = mid;
                low = mid + 1; // Try to achieve a longer running time
            } else {
                high = mid - 1; // Need to reduce the running time
            }
        }

        ans
    }
}