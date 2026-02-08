impl Solution {
    pub fn most_triggered_time(events: Vec<Vec<i32>>) -> Vec<i32> {
        let mut event_times = vec![];
        for event in events.iter() {
            event_times.push(event[0]);
            event_times.push(event[1]);
        }
        event_times.sort();
        let mut max_count = 0;
        let mut count = 0;
        let mut result = vec![];
        let mut last_time = i32::MIN;

        for time in event_times.iter() {
            if time != &last_time {
                if count > max_count {
                    max_count = count;
                    result.clear();
                    result.push(*time);
                } else if count == max_count {
                    result.push(*time);
                }
                last_time = *time;
            }
            count += 1;
        }

        result
    }
}