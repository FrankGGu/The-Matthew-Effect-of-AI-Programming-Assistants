use std::collections::VecDeque;

impl Solution {
    pub fn max_distance(grid: Vec<Vec<i32>>) -> i32 {
        let n = grid.len();
        let mut queue = VecDeque::new();
        let mut visited = vec![vec![false; n]; n];
        let directions = [(0, 1), (1, 0), (0, -1), (-1, 0)];

        for i in 0..n {
            for j in 0..n {
                if grid[i][j] == 1 {
                    queue.push_back((i as i32, j as i32, 0));
                    visited[i][j] = true;
                }
            }
        }

        let mut max_distance = -1;

        while let Some((x, y, dist)) = queue.pop_front() {
            for &(dx, dy) in &directions {
                let nx = x + dx;
                let ny = y + dy;
                if nx >= 0 && nx < n as i32 && ny >= 0 && ny < n as i32 && !visited[nx as usize][ny as usize] {
                    visited[nx as usize][ny as usize] = true;
                    max_distance = dist + 1;
                    queue.push_back((nx, ny, max_distance));
                }
            }
        }

        max_distance
    }
}