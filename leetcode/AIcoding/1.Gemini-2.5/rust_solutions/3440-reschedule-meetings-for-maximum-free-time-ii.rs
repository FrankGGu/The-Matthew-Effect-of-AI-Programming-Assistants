impl Solution {
    pub fn max_free_time(meetings: Vec<Vec<i32>>) -> i32 {
        if meetings.is_empty() {
            return 0;
        }

        let mut sorted_meetings = meetings;
        sorted_meetings.sort_unstable_by_key(|m| m[0]);

        let mut merged_intervals: Vec<Vec<i32>> = Vec::new();
        for meeting in sorted_meetings {
            if merged_intervals.is_empty() || meeting[0] > merged_intervals.last().unwrap()[1] {
                merged_intervals.push(meeting);
            } else {
                let last_interval = merged_intervals.last_mut().unwrap();
                last_interval[1] = last_interval[1].max(meeting[1]);
            }
        }

        let mut max_gap = 0;
        if merged_intervals.len() <= 1 {
            return 0;
        }

        for i in 0..merged_intervals.len() - 1 {
            let gap = merged_intervals[i+1][0] - merged_intervals[i][1];
            max_gap = max_gap.max(gap);
        }

        max_gap
    }
}