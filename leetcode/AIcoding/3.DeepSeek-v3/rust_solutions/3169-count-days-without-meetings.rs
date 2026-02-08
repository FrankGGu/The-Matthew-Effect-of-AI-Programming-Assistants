impl Solution {
    pub fn count_days(days: i32, meetings: Vec<Vec<i32>>) -> i32 {
        if meetings.is_empty() {
            return days;
        }
        let mut meetings = meetings;
        meetings.sort_by(|a, b| a[0].cmp(&b[0]));

        let mut merged = Vec::new();
        merged.push(meetings[0].clone());

        for meeting in meetings.iter().skip(1) {
            let last = merged.last_mut().unwrap();
            if meeting[0] <= last[1] {
                last[1] = last[1].max(meeting[1]);
            } else {
                merged.push(meeting.clone());
            }
        }

        let mut meeting_days = 0;
        for interval in merged {
            meeting_days += interval[1] - interval[0] + 1;
        }

        days - meeting_days
    }
}