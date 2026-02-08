impl Solution {
    pub fn max_free_time(meetings: Vec<Vec<i32>>, new_meeting: Vec<i32>) -> Vec<i32> {
        let mut all_meetings = meetings.clone();
        all_meetings.push(new_meeting);
        all_meetings.sort_unstable();

        let mut merged: Vec<Vec<i32>> = Vec::new();
        let mut current = all_meetings[0].clone();

        for meeting in all_meetings.iter().skip(1) {
            if meeting[0] <= current[1] {
                current[1] = current[1].max(meeting[1]);
            } else {
                merged.push(current);
                current = meeting.clone();
            }
        }
        merged.push(current);

        let mut max_free_time = 0;
        let mut free_time_range = vec![-1, -1];

        for i in 1..merged.len() {
            let free_time = merged[i][0] - merged[i - 1][1];
            if free_time > max_free_time {
                max_free_time = free_time;
                free_time_range = vec![merged[i - 1][1], merged[i][0]];
            }
        }

        free_time_range
    }
}