impl Solution {
    pub fn min_time_to_cross_bridge(mut times: Vec<i32>) -> i32 {
        times.sort_unstable();
        let mut n = times.len();
        let mut total_time = 0;

        while n > 3 {
            // Option 1: The two fastest people (times[0], times[1]) help the two slowest (times[n-2], times[n-1]).
            // 1. times[0] and times[1] cross (cost: times[1])
            // 2. times[0] returns (cost: times[0])
            // 3. times[n-2] and times[n-1] cross (cost: times[n-1])
            // 4. times[1] returns (cost: times[1])
            // Total cost for this pattern: times[1] + times[0] + times[n-1] + times[1]
            let option1 = times[1] + times[0] + times[n - 1] + times[1];

            // Option 2: The fastest person (times[0]) escorts the two slowest (times[n-2], times[n-1]).
            // 1. times[0] and times[n-1] cross (cost: times[n-1])
            // 2. times[0] returns (cost: times[0])
            // 3. times[0] and times[n-2] cross (cost: times[n-2])
            // 4. times[0] returns (cost: times[0])
            // Total cost for this pattern: times[n-1] + times[0] + times[n-2] + times[0]
            let option2 = times[n - 1] + times[0] + times[n - 2] + times[0];

            total_time += option1.min(option2);
            n -= 2; // Two people have crossed permanently
        }

        match n {
            0 => {}
            1 => {
                total_time += times[0];
            }
            2 => {
                total_time += times[1];
            }
            3 => {
                total_time += times[0] + times[1] + times[2];
            }
            _ => unreachable!(), // Should not be reached based on the loop condition
        }

        total_time
    }
}