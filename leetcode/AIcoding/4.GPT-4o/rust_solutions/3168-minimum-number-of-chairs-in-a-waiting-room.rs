use std::collections::BinaryHeap;

pub fn minimum_chairs(time: Vec<Vec<i32>>) -> i32 {
    let mut events: Vec<(i32, i32)> = Vec::new();
    for t in time {
        events.push((t[0], 1));
        events.push((t[1], -1));
    }
    events.sort();

    let mut max_chairs = 0;
    let mut current_chairs = 0;

    for (_, delta) in events {
        current_chairs += delta;
        max_chairs = max_chairs.max(current_chairs);
    }

    max_chairs
}