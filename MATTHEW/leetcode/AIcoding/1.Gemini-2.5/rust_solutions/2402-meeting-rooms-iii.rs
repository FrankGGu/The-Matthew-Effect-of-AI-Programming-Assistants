impl Solution {
    pub fn most_booked(n: i32, meetings: Vec<Vec<i32>>) -> i32 {
        let n_usize = n as usize;
        let mut room_availability_time: Vec<i64> = vec![0; n_usize];
        let mut meeting_counts: Vec<i32> = vec![0; n_usize];

        let mut sorted_meetings = meetings;
        sorted_meetings.sort_unstable_by_key(|m| m[0]);

        for meeting in sorted_meetings {
            let start = meeting[0] as i64;
            let end = meeting[1] as i64;
            let duration = end - start;

            let mut chosen_room_idx = -1;
            let mut actual_start_time = 0;

            for i in 0..n_usize {
                if room_availability_time[i] <= start {
                    chosen_room_idx = i as i32;
                    break;
                }
            }

            if chosen_room_idx == -1 {
                let mut min_finish_time_for_busy_room = room_availability_time[0];
                let mut room_with_min_finish_time = 0;

                for i in 1..n_usize {
                    if room_availability_time[i] < min_finish_time_for_busy_room {
                        min_finish_time_for_busy_room = room_availability_time[i];
                        room_with_min_finish_time = i;
                    }
                }
                chosen_room_idx = room_with_min_finish_time as i32;
                actual_start_time = min_finish_time_for_busy_room;
            } else {
                actual_start_time = start;
            }

            let actual_end_time = actual_start_time + duration;
            room_availability_time[chosen_room_idx as usize] = actual_end_time;
            meeting_counts[chosen_room_idx as usize] += 1;
        }

        let mut max_meetings = 0;
        let mut result_room_idx = 0;

        for i in 0..n_usize {
            if meeting_counts[i] > max_meetings {
                max_meetings = meeting_counts[i];
                result_room_idx = i as i32;
            }
        }
        result_room_idx
    }
}