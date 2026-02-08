impl Solution {
    pub fn find_poisoned_duration(time_series: Vec<i32>, duration: i32) -> i32 {
        if time_series.is_empty() {
            return 0;
        }
        let mut total = 0;
        for i in 0..time_series.len() - 1 {
            total += std::cmp::min(time_series[i + 1] - time_series[i], duration);
        }
        total + duration
    }
}