impl Solution {
    pub fn find_minimum_log_transportation_cost(logs: Vec<i32>, truck_capacity: i32, cost_per_truck: i32) -> i32 {
        let mut logs = logs;
        logs.sort_unstable();

        let mut trips = 0;
        let mut left = 0;
        let mut right = logs.len() as i32 - 1;

        while left <= right {
            trips += 1;
            if logs[left as usize] + logs[right as usize] <= truck_capacity {
                left += 1;
            }
            right -= 1;
        }

        trips * cost_per_truck
    }
}