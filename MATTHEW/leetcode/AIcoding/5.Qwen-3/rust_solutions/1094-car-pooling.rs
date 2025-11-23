impl Solution {

use std::cmp::Ordering;

struct Solution;

impl Solution {
    pub fn car_pooling(mut trips: Vec<Vec<i32>>, capacity: i32) -> bool {
        let mut events = Vec::new();

        for trip in trips {
            let (start, end, passengers) = (trip[0], trip[1], trip[2]);
            events.push((start, passengers));
            events.push((end, -passengers));
        }

        events.sort_by(|a, b| {
            if a.0 != b.0 {
                a.0.cmp(&b.0)
            } else {
                a.1.cmp(&b.1)
            }
        });

        let mut current_passengers = 0;
        for event in events {
            current_passengers += event.1;
            if current_passengers > capacity {
                return false;
            }
        }

        true
    }
}
}