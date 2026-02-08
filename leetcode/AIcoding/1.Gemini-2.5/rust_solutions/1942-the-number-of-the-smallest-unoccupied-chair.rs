use std::collections::BTreeSet;

impl Solution {
    pub fn smallest_unoccupied_chair(times: Vec<Vec<i32>>, target_friend: i32) -> i32 {
        let n = times.len();
        let target_friend_idx = target_friend as usize;

        let mut events: Vec<(i32, i32, usize)> = Vec::with_capacity(2 * n);

        for (i, time_pair) in times.iter().enumerate() {
            let arrival_time = time_pair[0];
            let departure_time = time_pair[1];
            events.push((arrival_time, 1, i)); // Event type 1 for arrival
            events.push((departure_time, 0, i)); // Event type 0 for departure
        }

        // Sort events: primary by time, secondary by event_type
        // (0 for departure comes before 1 for arrival at the same time)
        events.sort_unstable();

        let mut available_chairs: BTreeSet<i32> = (0..n as i32).collect();

        let mut friend_chair_map: Vec<i32> = vec![-1; n];

        for (time, event_type, friend_id) in events {
            if event_type == 0 { // Departure event
                let chair_to_free = friend_chair_map[friend_id];
                available_chairs.insert(chair_to_free);
            } else { // Arrival event
                let chair = *available_chairs.iter().next().unwrap();
                available_chairs.remove(&chair);

                friend_chair_map[friend_id] = chair;

                if friend_id == target_friend_idx {
                    return chair;
                }
            }
        }

        -1 
    }
}