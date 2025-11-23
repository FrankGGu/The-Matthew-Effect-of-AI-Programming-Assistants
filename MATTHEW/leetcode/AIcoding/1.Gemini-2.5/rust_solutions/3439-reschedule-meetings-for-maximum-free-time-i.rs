impl Solution {
    pub fn max_free_time(meetings: Vec<Vec<i32>>) -> Vec<i32> {
        if meetings.is_empty() {
            return vec![0, 0];
        }

        let mut meetings = meetings;
        meetings.sort_by_key(|m| m[0]);

        let mut merged_intervals: Vec<Vec<i32>> = Vec::new();
        for meeting in meetings {
            if merged_intervals.is_empty() || meeting[0] > merged_intervals.last().unwrap()[1] {
                merged_intervals.push(meeting);
            } else {
                let last = merged_intervals.last_mut().unwrap();
                last[1] = last[1].max(meeting[1]);
            }
        }

        let mut max_free_time_len = 0;
        let mut max_free_time_interval = vec![0, 0];

        for i in 0..merged_intervals.len() - 1 {
            let current_end = merged_intervals[i][1];
            let next_start = merged_intervals[i+1][0];

            if next_start > current_end {
                let free_time_len = next_start - current_end;
                if free_time_len > max_free_time_len {
                    max_free_time_len = free_time_len;
                    max_free_time_interval = vec![current_end, next_start];
                }
            }
        }

        max_free_time_interval
    }
}