use std::collections::BinaryHeap;

pub fn min_meeting_rooms(intervals: Vec<Vec<i32>>) -> i32 {
    let mut start_times: Vec<i32> = intervals.iter().map(|x| x[0]).collect();
    let mut end_times: Vec<i32> = intervals.iter().map(|x| x[1]).collect();

    start_times.sort();
    end_times.sort();

    let mut rooms = 0;
    let mut end_ptr = 0;

    for start in start_times {
        if start >= end_times[end_ptr] {
            end_ptr += 1;
        } else {
            rooms += 1;
        }
    }

    rooms
}