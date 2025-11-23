impl Solution {
    pub fn find_poisoned_duration(time_series: Vec<i32>, duration: i32) -> i32 {
        if time_series.is_empty() {
            return 0;
        }

        let mut total_poisoned_time = 0;
        let n = time_series.len();

        for i in 0..(n - 1) {
            let end_of_current_poison = time_series[i] + duration;
            let start_of_next_poison = time_series[i + 1];

            if start_of_next_poison < end_of_current_poison {
                total_poisoned_time += start_of_next_poison - time_series[i];
            } else {
                total_poisoned_time += duration;
            }
        }

        total_poisoned_time += duration;

        total_poisoned_time
    }
}