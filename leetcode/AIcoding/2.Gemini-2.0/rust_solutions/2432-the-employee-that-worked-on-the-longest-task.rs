impl Solution {
    pub fn hardest_worker(n: i32, logs: Vec<Vec<i32>>) -> i32 {
        let mut max_duration = 0;
        let mut hardest_worker = logs[0][0];
        let mut prev_time = 0;

        for log in logs {
            let id = log[0];
            let end_time = log[1];
            let duration = end_time - prev_time;

            if duration > max_duration {
                max_duration = duration;
                hardest_worker = id;
            } else if duration == max_duration {
                hardest_worker = hardest_worker.min(id);
            }

            prev_time = end_time;
        }

        hardest_worker
    }
}