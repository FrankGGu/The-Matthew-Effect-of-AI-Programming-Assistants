pub fn robot_sim(commands: Vec<i32>, obstacles: Vec<Vec<i32>>) -> i32 {
    let mut direction = [(0, 1), (1, 0), (0, -1), (-1, 0)];
    let mut x = 0;
    let mut y = 0;
    let mut d = 0;
    let mut obstacle_set = std::collections::HashSet::new();

    for obs in obstacles {
        obstacle_set.insert((obs[0], obs[1]));
    }

    let mut max_distance = 0;

    for &cmd in &commands {
        match cmd {
            -2 => d = (d + 3) % 4,
            -1 => d = (d + 1) % 4,
            _ => {
                for _ in 0..cmd {
                    let new_x = x + direction[d].0;
                    let new_y = y + direction[d].1;
                    if !obstacle_set.contains(&(new_x, new_y)) {
                        x = new_x;
                        y = new_y;
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