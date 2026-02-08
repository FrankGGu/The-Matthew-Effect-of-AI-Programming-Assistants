pub fn can_reach_destination(traffic_signals: Vec<Vec<i32>>, start: Vec<i32>, destination: Vec<i32>) -> bool {
    use std::collections::HashSet;

    let mut visited = HashSet::new();
    let mut queue = vec![start];

    let directions = vec![(0, 1), (1, 0), (0, -1), (-1, 0)];

    while let Some(current) = queue.pop() {
        if current == destination {
            return true;
        }
        if visited.contains(&(current[0], current[1])) {
            continue;
        }
        visited.insert((current[0], current[1]));

        for &(dx, dy) in &directions {
            let next = vec![current[0] + dx, current[1] + dy];
            if next[0] >= 0 && next[0] < traffic_signals.len() as i32
                && next[1] >= 0 && next[1] < traffic_signals[0].len() as i32
                && (traffic_signals[next[0] as usize][next[1] as usize] == 0
                    || (next == destination)) {
                queue.push(next);
            }
        }
    }

    false
}