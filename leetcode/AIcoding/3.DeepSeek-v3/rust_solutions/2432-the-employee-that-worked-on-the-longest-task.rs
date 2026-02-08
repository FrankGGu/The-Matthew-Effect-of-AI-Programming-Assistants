impl Solution {
    pub fn hardest_worker(n: i32, logs: Vec<Vec<i32>>) -> i32 {
        let mut max_duration = 0;
        let mut result = 0;
        let mut prev_time = 0;

        for log in logs {
            let id = log[0];
            let leave_time = log[1];
            let duration = leave_time - prev_time;

            if duration > max_duration || (duration == max_duration && id < result) {
                max_duration = duration;
                result = id;
            }

            prev_time = leave_time;
        }

        result
    }
}