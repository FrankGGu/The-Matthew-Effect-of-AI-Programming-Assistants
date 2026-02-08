impl Solution {
    pub fn number_of_days_without_meetings(meetings: Vec<Vec<i32>>) -> i32 {
        let mut meetings_sorted = meetings;
        meetings_sorted.sort_by(|a, b| a[0].cmp(&b[0]));

        let mut current_day = 0;
        for meeting in meetings_sorted {
            let start_day = meeting[0];
            let duration = meeting[1];

            if current_day > start_day {
                current_day += duration;
            } else {
                current_day = start_day + duration;
            }
        }

        current_day
    }
}