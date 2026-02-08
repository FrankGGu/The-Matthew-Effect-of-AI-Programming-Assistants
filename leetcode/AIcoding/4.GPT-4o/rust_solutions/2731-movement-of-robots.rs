pub fn robot_sim(commands: Vec<i32>, obstacles: Vec<Vec<i32>>) -> i32 {
    use std::collections::HashSet;
    let mut obstacles_set = HashSet::new();
    for obs in obstacles {
        obstacles_set.insert((obs[0], obs[1]));
    }

    let directions = vec![(0, 1), (1, 0), (0, -1), (-1, 0)];
    let mut x = 0;
    let mut y = 0;
    let mut dir = 0;
    let mut max_distance = 0;

    for cmd in commands {
        match cmd {
            -2 => dir = (dir + 3) % 4,
            -1 => dir = (dir + 1) % 4,
            steps => {
                for _ in 0..steps {
                    let new_x = x + directions[dir].0;
                    let new_y = y + directions[dir].1;
                    if !obstacles_set.contains(&(new_x, new_y)) {
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