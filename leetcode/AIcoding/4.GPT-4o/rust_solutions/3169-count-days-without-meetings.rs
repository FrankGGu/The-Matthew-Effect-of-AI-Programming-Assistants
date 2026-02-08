impl Solution {
    pub fn count_days_without_meetings(arrival: Vec<i32>, meeting: Vec<i32>) -> i32 {
        let mut days_without_meeting = 0;
        let mut day_set = std::collections::HashSet::new();

        for &m in &meeting {
            day_set.insert(m);
        }

        for &d in &arrival {
            if !day_set.contains(&d) {
                days_without_meeting += 1;
            }
        }

        days_without_meeting
    }
}