pub fn find_poisoned_duration(time_series: Vec<i32>, duration: i32) -> i32 {
    if time_series.is_empty() {
        return 0;
    }

    let mut total_duration = 0;
    let mut end_time = time_series[0] + duration;

    for &time in &time_series[1..] {
        if time < end_time {
            total_duration += time - time_series[total_duration as usize];
        } else {
            total_duration += duration;
        }
        end_time = time + duration;
    }

    total_duration + duration
}