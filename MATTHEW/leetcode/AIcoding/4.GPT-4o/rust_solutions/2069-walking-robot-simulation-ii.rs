pub fn robot_sim(commands: Vec<i32>, obstacles: Vec<Vec<i32>>) -> i32 {
    let mut pos = (0, 0);
    let mut dir = 0; // 0: north, 1: east, 2: south, 3: west
    let mut max_distance = 0;
    let mut obstacle_set = std::collections::HashSet::new();

    for obstacle in obstacles {
        obstacle_set.insert((obstacle[0], obstacle[1]));
    }

    for command in commands {
        match command {
            -2 => dir = (dir + 3) % 4, // turn left
            -1 => dir = (dir + 1) % 4, // turn right
            _ => {
                for _ in 0..command {
                    let (dx, dy) = match dir {
                        0 => (0, 1),
                        1 => (1, 0),
                        2 => (0, -1),
                        _ => (-1, 0),
                    };
                    let new_pos = (pos.0 + dx, pos.1 + dy);
                    if !obstacle_set.contains(&new_pos) {
                        pos = new_pos;
                        max_distance = max_distance.max(pos.0.pow(2) + pos.1.pow(2));
                    } else {
                        break;
                    }
                }
            }
        }
    }
    max_distance
}