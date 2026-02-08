use std::collections::{HashSet, VecDeque};

impl Solution {
    pub fn minimal_steps(maze: Vec<String>) -> i32 {
        let maze: Vec<Vec<char>> = maze.into_iter().map(|s| s.chars().collect()).collect();
        let (rows, cols) = (maze.len(), maze[0].len());
        let mut starts = Vec::new();
        let mut targets = Vec::new();
        let mut stones = Vec::new();
        let mut obstacles = HashSet::new();

        for i in 0..rows {
            for j in 0..cols {
                match maze[i][j] {
                    'S' => starts.push((i, j)),
                    'T' => targets.push((i, j)),
                    'O' => stones.push((i, j)),
                    '#' => { obstacles.insert((i, j)); },
                    _ => (),
                }
            }
        }

        if starts.is_empty() || targets.is_empty() {
            return -1;
        }

        let start = starts[0];
        let target = targets[0];

        let mut dist_to_stones = vec![vec![-1; cols]; rows];
        let mut queue = VecDeque::new();
        queue.push_back((start.0, start.1));
        dist_to_stones[start.0][start.1] = 0;

        let dirs = [(-1, 0), (1, 0), (0, -1), (0, 1)];

        while let Some((x, y)) = queue.pop_front() {
            for (dx, dy) in dirs.iter() {
                let nx = x as i32 + dx;
                let ny = y as i32 + dy;
                if nx >= 0 && nx < rows as i32 && ny >= 0 && ny < cols as i32 {
                    let nx = nx as usize;
                    let ny = ny as usize;
                    if !obstacles.contains(&(nx, ny)) && dist_to_stones[nx][ny] == -1 {
                        dist_to_stones[nx][ny] = dist_to_stones[x][y] + 1;
                        queue.push_back((nx, ny));
                    }
                }
            }
        }

        let mut min_steps = i32::MAX;

        for &stone in &stones {
            if dist_to_stones[stone.0][stone.1] == -1 {
                continue;
            }

            let mut dist_to_target = vec![vec![-1; cols]; rows];
            let mut queue = VecDeque::new();
            queue.push_back((stone.0, stone.1));
            dist_to_target[stone.0][stone.1] = 0;

            while let Some((x, y)) = queue.pop_front() {
                for (dx, dy) in dirs.iter() {
                    let nx = x as i32 + dx;
                    let ny = y as i32 + dy;
                    if nx >= 0 && nx < rows as i32 && ny >= 0 && ny < cols as i32 {
                        let nx = nx as usize;
                        let ny = ny as usize;
                        if !obstacles.contains(&(nx, ny)) && dist_to_target[nx][ny] == -1 {
                            dist_to_target[nx][ny] = dist_to_target[x][y] + 1;
                            queue.push_back((nx, ny));
                        }
                    }
                }
            }

            if dist_to_target[target.0][target.1] != -1 {
                let total = dist_to_stones[stone.0][stone.1] + dist_to_target[target.0][target.1];
                if total < min_steps {
                    min_steps = total;
                }
            }
        }

        if min_steps != i32::MAX {
            min_steps
        } else {
            -1
        }
    }
}