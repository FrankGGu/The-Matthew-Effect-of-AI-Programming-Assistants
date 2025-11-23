impl Solution {
    pub fn robot_sim(commands: Vec<i32>, obstacles: Vec<Vec<i32>>) -> i32 {
        let mut x = 0;
        let mut y = 0;
        let mut dir = 0; // 0: North, 1: East, 2: South, 3: West
        let dx = [0, 1, 0, -1];
        let dy = [1, 0, -1, 0];
        let mut max_dist = 0;

        let obstacle_set: std::collections::HashSet<(i32, i32)> = obstacles.iter().map(|v| (v[0], v[1])).collect();

        for &command in &commands {
            match command {
                -2 => {
                    dir = (dir + 3) % 4;
                }
                -1 => {
                    dir = (dir + 1) % 4;
                }
                _ => {
                    for _ in 0..command {
                        let next_x = x + dx[dir];
                        let next_y = y + dy[dir];
                        if obstacle_set.contains(&(next_x, next_y)) {
                            break;
                        }
                        x = next_x;
                        y = next_y;
                        max_dist = max_dist.max(x * x + y * y);
                    }
                }
            }
        }

        max_dist
    }
}