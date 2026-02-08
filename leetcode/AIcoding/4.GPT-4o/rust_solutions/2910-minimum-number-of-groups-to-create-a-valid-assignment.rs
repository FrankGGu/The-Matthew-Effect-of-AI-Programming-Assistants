pub fn min_groups(intervals: Vec<Vec<i32>>) -> i32 {
    let mut events = vec![];
    for interval in intervals {
        events.push((interval[0], 1));
        events.push((interval[1] + 1, -1));
    }
    events.sort();

    let mut max_groups = 0;
    let mut current_groups = 0;

    for (_, delta) in events {
        current_groups += delta;
        max_groups = max_groups.max(current_groups);
    }

    max_groups
}