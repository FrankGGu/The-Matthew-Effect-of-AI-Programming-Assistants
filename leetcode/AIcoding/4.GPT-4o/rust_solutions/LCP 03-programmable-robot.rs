pub fn robot_sim(commands: Vec<i32>, obstacles: Vec<Vec<i32>>) -> i32 {
    use std::collections::HashSet;

    let mut obstacle_set = HashSet::new();
    for obs in obstacles {
        obstacle_set.insert((obs[0], obs[1]));
    }

    let mut x = 0;
    let mut y = 0;
    let mut direction = 0;
    let directions = vec![(0, 1), (1, 0), (0, -1), (-1, 0)];
    let mut max_distance = 0;

    for &command in &commands {
        match command {
            -2 => direction = (direction + 3) % 4,
            -1 => direction = (direction + 1) % 4,
            _ => {
                for _ in 0..command {
                    let nx = x + directions[direction].0;
                    let ny = y + directions[direction].1;
                    if !obstacle_set.contains(&(nx, ny)) {
                        x = nx;
                        y = ny;
                        max_distance = max_distance.max(x * x + y * y);
                    } else {
                        break;
                    }
                }
            }
        }
    }

    max_distance
}