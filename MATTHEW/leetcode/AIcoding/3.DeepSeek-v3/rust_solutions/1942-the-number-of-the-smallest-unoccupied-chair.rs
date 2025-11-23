use std::collections::BinaryHeap;

impl Solution {
    pub fn smallest_chair(times: Vec<Vec<i32>>, target_friend: i32) -> i32 {
        let n = times.len();
        let mut events = Vec::with_capacity(2 * n);
        for (i, time) in times.iter().enumerate() {
            events.push((time[0], 1, i as i32)); // arrive
            events.push((time[1], 0, i as i32)); // leave
        }
        events.sort_unstable();

        let mut available_chairs: BinaryHeap<i32> = BinaryHeap::new();
        for i in 0..n {
            available_chairs.push(-(i as i32));
        }
        let mut friend_to_chair = vec![0; n];

        for (time, typ, friend) in events {
            if typ == 0 {
                available_chairs.push(-friend_to_chair[friend as usize]);
            } else {
                let chair = -available_chairs.pop().unwrap();
                friend_to_chair[friend as usize] = chair;
                if friend == target_friend {
                    return chair;
                }
            }
        }
        -1
    }
}