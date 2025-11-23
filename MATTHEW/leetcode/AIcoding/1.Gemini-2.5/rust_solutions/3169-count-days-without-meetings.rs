impl Solution {
    pub fn count_days_without_meetings(days: i32, meetings: Vec<Vec<i32>>) -> i32 {
        if meetings.is_empty() {
            return days;
        }

        let mut sorted_meetings = meetings;
        sorted_meetings.sort_unstable_by_key(|m| m[0]);

        let mut merged_intervals: Vec<Vec<i32>> = Vec::new();

        for meeting in sorted_meetings {
            if merged_intervals.is_empty() || meeting[0] > merged_intervals.last().unwrap()[1] {
                merged_intervals.push(meeting);
            } else {
                let last_idx = merged_intervals.len() - 1;
                merged_intervals[last_idx][1] = merged_intervals[last_idx][1].max(meeting[1]);
            }
        }

        let mut total_meeting_days = 0;
        for interval in merged_intervals {
            total_meeting_days += interval[1] - interval[0] + 1;
        }

        days - total_meeting_days
    }
}