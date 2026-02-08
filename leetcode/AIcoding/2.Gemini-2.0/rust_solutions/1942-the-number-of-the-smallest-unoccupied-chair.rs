use std::collections::BinaryHeap;
use std::cmp::Reverse;

impl Solution {
    pub fn smallest_chair(times: Vec<Vec<i32>>, target_friend: i32) -> i32 {
        let mut events: Vec<(i32, i32, i32)> = Vec::new();
        for (i, time) in times.iter().enumerate() {
            events.push((time[0], 0, i as i32)); // 0 for arrival
            events.push((time[1], 1, i as i32)); // 1 for departure
        }
        events.sort();

        let mut available_chairs: BinaryHeap<Reverse<i32>> = BinaryHeap::new();
        for i in 0..=times.len() as i32 {
            available_chairs.push(Reverse(i));
        }

        let mut assignment: std::collections::HashMap<i32, i32> = std::collections::HashMap::new();
        for event in events {
            let (time, event_type, friend_id) = event;
            if event_type == 0 {
                let chair = available_chairs.pop().unwrap().0;
                assignment.insert(friend_id, chair);
                if friend_id == target_friend {
                    return chair;
                }
            } else {
                let chair = *assignment.get(&friend_id).unwrap();
                available_chairs.push(Reverse(chair));
            }
        }
        -1
    }
}