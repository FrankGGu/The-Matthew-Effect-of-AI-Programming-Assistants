use std::cmp::Ordering;

pub fn max_events(events: Vec<Vec<i32>>) -> i32 {
    let mut events = events;
    events.sort_by(|a, b| {
        if a[0] != b[0] {
            a[0].cmp(&b[0])
        } else {
            a[1].cmp(&b[1])
        }
    });

    let mut count = 0;
    let mut end_time = 0;

    for event in events {
        if event[0] > end_time {
            count += 1;
            end_time = event[1];
        } else if event[1] > end_time {
            count += 1;
            end_time = event[1];
        }
    }

    count
}