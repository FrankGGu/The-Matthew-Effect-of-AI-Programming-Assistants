pub fn count_covered_buildings(buildings: Vec<Vec<i32>>) -> i32 {
    let mut events = Vec::new();
    for building in buildings {
        events.push((building[0], 1));
        events.push((building[1], -1));
    }
    events.sort_by(|a, b| (a.0, a.1.cmp(&b.1)));

    let mut count = 0;
    let mut current_coverage = 0;
    let mut last_position = events[0].0;

    for (position, delta) in events {
        if current_coverage > 0 {
            count += position - last_position;
        }
        current_coverage += delta;
        last_position = position;
    }

    count
}