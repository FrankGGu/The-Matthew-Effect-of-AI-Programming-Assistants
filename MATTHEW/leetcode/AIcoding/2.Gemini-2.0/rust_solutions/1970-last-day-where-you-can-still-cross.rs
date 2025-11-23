impl Solution {
    pub fn latest_day_to_cross(row: i32, col: i32, cells: Vec<Vec<i32>>) -> i32 {
        let row = row as usize;
        let col = col as usize;
        let mut left = 0;
        let mut right = cells.len() as i32 - 1;

        while left <= right {
            let mid = left + (right - left) / 2;
            let mut grid = vec![vec![0; col]; row];

            for i in 0..=mid as usize {
                grid[cells[i][0] as usize - 1][cells[i][1] as usize - 1] = 1;
            }

            if Self::can_cross(&grid) {
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }

        right
    }

    fn can_cross(grid: &Vec<Vec<i32>>) -> bool {
        let row = grid.len();
        let col = grid[0].len();
        let mut visited = vec![vec![false; col]; row];
        let mut queue = std::collections::VecDeque::new();

        for j in 0..col {
            if grid[0][j] == 0 {
                queue.push_back((0, j));
                visited[0][j] = true;
            }
        }

        while let Some((r, c)) = queue.pop_front() {
            if r == row - 1 {
                return true;
            }

            let directions = [(0, 1), (0, -1), (1, 0), (-1, 0)];
            for (dr, dc) in directions {
                let nr = r as i32 + dr;
                let nc = c as i32 + dc;

                if nr >= 0 && nr < row as i32 && nc >= 0 && nc < col as i32 {
                    let nr = nr as usize;
                    let nc = nc as usize;

                    if grid[nr][nc] == 0 && !visited[nr][nc] {
                        queue.push_back((nr, nc));
                        visited[nr][nc] = true;
                    }
                }
            }
        }

        false
    }
}