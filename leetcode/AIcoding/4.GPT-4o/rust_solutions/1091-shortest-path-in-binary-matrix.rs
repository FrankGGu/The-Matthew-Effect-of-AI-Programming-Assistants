use std::collections::VecDeque;

impl Solution {
    pub fn shortest_path_binary_matrix(grid: Vec<Vec<i32>>) -> i32 {
        let n = grid.len();
        if grid[0][0] == 1 || grid[n - 1][n - 1] == 1 {
            return -1;
        }

        let directions = vec![
            (1, 0), (0, 1), (1, 1),
            (0, -1), (-1, 0), (-1, -1),
            (-1, 1), (1, -1)
        ];

        let mut queue = VecDeque::new();
        queue.push_back((0, 0, 1));

        while let Some((x, y, dist)) = queue.pop_front() {
            if x == n as i32 - 1 && y == n as i32 - 1 {
                return dist;
            }
            for (dx, dy) in &directions {
                let nx = x + dx;
                let ny = y + dy;
                if nx >= 0 && ny >= 0 && nx < n as i32 && ny < n as i32 && grid[nx as usize][ny as usize] == 0 {
                    grid[nx as usize][ny as usize] = 1;
                    queue.push_back((nx, ny, dist + 1));
                }
            }
        }

        -1
    }
}