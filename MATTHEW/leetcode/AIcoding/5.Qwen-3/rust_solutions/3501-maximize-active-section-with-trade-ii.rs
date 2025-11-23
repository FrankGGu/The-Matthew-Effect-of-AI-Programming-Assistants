impl Solution {

use std::collections::VecDeque;

impl Solution {
    pub fn max_active_section(trades: Vec<Vec<i32>>) -> i32 {
        let mut events = Vec::new();
        for trade in trades {
            let start = trade[0];
            let end = trade[1];
            let value = trade[2];
            events.push((start, value));
            events.push((end + 1, -value));
        }

        events.sort();

        let mut max_active = 0;
        let mut current_active = 0;
        let mut prev_time = 0;

        for (time, delta) in events {
            if prev_time != 0 && prev_time < time {
                max_active = max_active.max(current_active);
            }
            current_active += delta;
            prev_time = time;
        }

        max_active
    }
}
}