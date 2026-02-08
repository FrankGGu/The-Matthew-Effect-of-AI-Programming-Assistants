impl Solution {
    pub fn max_active_sections(trades: Vec<i32>) -> i32 {
        let mut max_active = 0;
        let mut current_active = 0;
        let mut events = Vec::new();

        for trade in trades {
            events.push((trade, 1));
            events.push((trade + 1, -1));
        }

        events.sort_unstable();

        let mut prev_time = -1;
        for (time, delta) in events {
            if time != prev_time {
                max_active = max_active.max(current_active);
                prev_time = time;
            }
            current_active += delta;
        }

        max_active
    }
}