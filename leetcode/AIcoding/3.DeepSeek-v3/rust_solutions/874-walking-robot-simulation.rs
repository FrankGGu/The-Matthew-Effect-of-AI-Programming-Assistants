use std::collections::HashSet;

impl Solution {
    pub fn robot_sim(commands: Vec<i32>, obstacles: Vec<Vec<i32>>) -> i32 {
        let mut obstacles_set: HashSet<(i32, i32)> = obstacles.into_iter().map(|v| (v[0], v[1])).collect();
        let directions = [(0, 1), (1, 0), (0, -1), (-1, 0)];
        let mut x = 0;
        let mut y = 0;
        let mut dir = 0;
        let mut max_distance = 0;

        for cmd in commands {
            if cmd == -2 {
                dir = (dir + 3) % 4;
            } else if cmd == -1 {
                dir = (dir + 1) % 4;
            } else {
                let (dx, dy) = directions[dir];
                for _ in 0..cmd {
                    let new_x = x + dx;
                    let new_y = y + dy;
                    if obstacles_set.contains(&(new_x, new_y)) {
                        break;
                    }
                    x = new_x;
                    y = new_y;
                    max_distance = max_distance.max(x * x + y * y);
                }
            }
        }

        max_distance
    }
}