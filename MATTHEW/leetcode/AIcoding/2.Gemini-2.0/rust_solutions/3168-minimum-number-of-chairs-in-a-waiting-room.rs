impl Solution {
    pub fn min_meeting_rooms(intervals: Vec<Vec<i32>>) -> i32 {
        let mut starts: Vec<i32> = intervals.iter().map(|v| v[0]).collect();
        let mut ends: Vec<i32> = intervals.iter().map(|v| v[1]).collect();

        starts.sort();
        ends.sort();

        let mut rooms = 0;
        let mut end_index = 0;

        for start in starts {
            if start < ends[end_index] {
                rooms += 1;
            } else {
                end_index += 1;
            }
        }

        rooms
    }
}

struct Solution;