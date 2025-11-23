struct Solution;

impl Solution {
    pub fn min_chairs(times: Vec<Vec<i32>>) -> i32 {
        let mut events: Vec<(i32, i32)> = Vec::new();

        for time_pair in times {
            let arrival = time_pair[0];
            let departure = time_pair[1];
            events.push((arrival, 1));
            events.push((departure, -1));
        }

        events.sort_unstable_by(|a, b| {
            if a.0 != b.0 {
                a.0.cmp(&b.0)
            } else {
                a.1.cmp(&b.1)
            }
        });

        let mut current_chairs = 0;
        let mut max_chairs = 0;

        for event in events {
            current_chairs += event.1;
            if current_chairs > max_chairs {
                max_chairs = current_chairs;
            }
        }

        max_chairs
    }
}