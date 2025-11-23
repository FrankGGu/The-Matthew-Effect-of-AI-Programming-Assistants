impl Solution {
    pub fn max_total_ime_free(meetings: Vec<Vec<i32>>) -> i32 {
        let mut events: Vec<(i32, i32)> = Vec::new();
        for meeting in &meetings {
            events.push((meeting[0], 1));
            events.push((meeting[1], -1));
        }
        events.sort();

        let mut max_free_time = 0;
        let mut count = 0;
        let mut prev_time = 0;

        for (time, type_) in events {
            if count == 0 && prev_time != 0 {
                max_free_time += time - prev_time;
            }
            count += type_;
            prev_time = time;
        }

        max_free_time
    }
}