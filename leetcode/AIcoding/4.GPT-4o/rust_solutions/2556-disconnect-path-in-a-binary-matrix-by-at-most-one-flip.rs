use std::collections::VecDeque;

impl Solution {
    pub fn shortest_path_with_one_flip(grid: Vec<Vec<i32>>) -> i32 {
        let (m, n) = (grid.len(), grid[0].len());
        let directions = vec![(1, 0), (0, 1), (-1, 0), (0, -1)];
        let mut queue = VecDeque::new();
        let mut visited = vec![vec![vec![false; 2]; n]; m];

        queue.push_back((0, 0, 0, 0)); // (row, col, flips, distance)
        visited[0][0][0] = true;

        while let Some((x, y, flips, dist)) = queue.pop_front() {
            if x == m - 1 && y == n - 1 {
                return dist;
            }
            for (dx, dy) in &directions {
                let (nx, ny) = (x as isize + dx, y as isize + dy);
                if nx >= 0 && nx < m as isize && ny >= 0 && ny < n as isize {
                    let next_flips = if grid[nx as usize][ny as usize] == 0 { flips } else { flips + 1 };
                    if next_flips <= 1 && !visited[nx as usize][ny as usize][next_flips] {
                        visited[nx as usize][ny as usize][next_flips] = true;
                        queue.push_back((nx as usize, ny as usize, next_flips, dist + 1));
                    }
                }
            }
        }

        -1
    }
}