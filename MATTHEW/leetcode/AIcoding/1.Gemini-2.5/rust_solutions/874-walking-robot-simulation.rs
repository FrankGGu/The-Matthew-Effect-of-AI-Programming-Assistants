use std::collections::HashSet;

impl Solution {
    pub fn robot_sim(commands: Vec<i32>, obstacles: Vec<Vec<i32>>) -> i32 {
        let mut x: i32 = 0;
        let mut y: i32 = 0;
        // 0: North, 1: East, 2: South, 3: West
        let mut dir: usize = 0; 

        let dx: [i32; 4] = [0, 1, 0, -1]; // Change in x for N, E, S, W
        let dy: [i32; 4] = [1, 0, -1, 0]; // Change in y for N, E, S, W

        let mut max_dist_sq: i32 = 0;

        let obstacle_set: HashSet<(i32, i32)> = obstacles.into_iter()
            .map(|obs| (obs[0], obs[1]))
            .collect();

        for command in commands {
            match command {
                -2 => { // Turn left
                    dir = (dir + 3) % 4;
                },
                -1 => { // Turn right
                    dir = (dir + 1) % 4;
                },
                _ => { // Move forward
                    for _ in 0..command {
                        let next_x = x + dx[dir];
                        let next_y = y + dy[dir];

                        if obstacle_set.contains(&(next_x, next_y)) {
                            break; // Hit an obstacle, stop moving in this direction
                        } else {
                            x = next_x;
                            y = next_y;
                            max_dist_sq = max_dist_sq.max(x * x + y * y);
                        }
                    }
                }
            }
        }

        max_dist_sq
    }
}