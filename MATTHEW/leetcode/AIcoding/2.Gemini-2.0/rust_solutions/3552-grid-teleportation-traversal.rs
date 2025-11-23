impl Solution {
    pub fn grid_teleportation_traversal(grid: Vec<Vec<i32>>) -> i32 {
        let m = grid.len();
        let n = grid[0].len();
        let mut visited = vec![vec![false; n]; m];
        let mut queue = std::collections::VecDeque::new();
        queue.push_back((0, 0, 0));
        visited[0][0] = true;

        while !queue.is_empty() {
            let (row, col, steps) = queue.pop_front().unwrap();

            if row == m - 1 && col == n - 1 {
                return steps;
            }

            let dr = [0, 0, 1, -1];
            let dc = [1, -1, 0, 0];

            for i in 0..4 {
                let nr = row as i32 + dr[i];
                let nc = col as i32 + dc[i];

                if nr >= 0 && nr < m as i32 && nc >= 0 && nc < n as i32 {
                    let nr = nr as usize;
                    let nc = nc as usize;
                    if !visited[nr][nc] && grid[nr][nc] == 0 {
                        visited[nr][nc] = true;
                        queue.push_back((nr, nc, steps + 1));
                    }
                }
            }

            if grid[row][col] > 0 {
                let tr = grid[row][col] as usize / n;
                let tc = grid[row][col] as usize % n;

                if !visited[tr][tc] && grid[tr][tc] == 0 {
                    visited[tr][tc] = true;
                    queue.push_back((tr, tc, steps + 1));
                }
            }
        }

        -1
    }
}