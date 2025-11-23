pub fn num_of_fireworks(launch_times: Vec<i32>, duration: i32) -> i32 {
    let mut events = Vec::new();

    for &time in &launch_times {
        events.push((time, 1));
        events.push((time + duration, -1));
    }

    events.sort();

    let mut count = 0;
    let mut max_count = 0;

    for (_, delta) in events {
        count += delta;
        max_count = max_count.max(count);
    }

    max_count
}