impl Solution {

use std::collections::{HashSet, VecDeque};

impl Solution {
    pub fn robot_sim(mut commands: Vec<i32>, obstacles: Vec<Vec<i32>>) -> Vec<i32> {
        let mut directions = [(0, 1), (1, 0), (0, -1), (-1, 0)];
        let mut x = 0;
        let mut y = 0;
        let mut dir = 0;
        let mut max_distance = 0;
        let obstacles_set: HashSet<(i32, i32)> = obstacles.into_iter().map(|o| (o[0], o[1])).collect();
        let mut queue = VecDeque::new();
        queue.push_back((x, y));

        for command in commands {
            if command == -1 {
                dir = (dir + 1) % 4;
            } else if command == -2 {
                dir = (dir + 3) % 4;
            } else {
                for _ in 0..command {
                    let (dx, dy) = directions[dir];
                    let nx = x + dx;
                    let ny = y + dy;
                    if obstacles_set.contains(&(nx, ny)) {
                        break;
                    }
                    x = nx;
                    y = ny;
                    queue.push_back((x, y));
                }
            }
        }

        while let Some((x, y)) = queue.pop_front() {
            max_distance = max_distance.max(x * x + y * y);
        }

        vec![max_distance as i32]
    }
}
}