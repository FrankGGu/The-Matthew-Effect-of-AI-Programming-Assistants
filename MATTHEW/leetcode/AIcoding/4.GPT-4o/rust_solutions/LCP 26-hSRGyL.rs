pub fn navigate(n: i32, start: Vec<i32>, end: Vec<i32>, obstacles: Vec<Vec<i32>>) -> i32 {
    use std::collections::HashSet;
    use std::collections::VecDeque;

    let mut obstacle_set = HashSet::new();
    for obstacle in obstacles {
        obstacle_set.insert((obstacle[0], obstacle[1]));
    }

    let directions = vec![(0, 1), (1, 0), (0, -1), (-1, 0)];
    let mut queue = VecDeque::new();
    queue.push_back((start[0], start[1], 0));
    let mut visited = HashSet::new();
    visited.insert((start[0], start[1]));

    while let Some((x, y, steps)) = queue.pop_front() {
        if x == end[0] && y == end[1] {
            return steps;
        }

        for (dx, dy) in &directions {
            let mut nx = x;
            let mut ny = y;
            while nx + dx >= 0 && nx + dx < n && ny + dy >= 0 && ny + dy < n && !obstacle_set.contains(&(nx + dx, ny + dy)) {
                nx += dx;
                ny += dy;
                if visited.insert((nx, ny)) {
                    queue.push_back((nx, ny, steps + 1));
                }
            }
        }
    }

    -1
}