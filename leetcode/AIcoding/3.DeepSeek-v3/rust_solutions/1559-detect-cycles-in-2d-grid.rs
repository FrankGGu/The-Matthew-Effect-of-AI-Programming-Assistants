impl Solution {
    pub fn contains_cycle(grid: Vec<Vec<char>>) -> bool {
        let rows = grid.len();
        if rows == 0 {
            return false;
        }
        let cols = grid[0].len();
        let mut visited = vec![vec![false; cols]; rows];

        for i in 0..rows {
            for j in 0..cols {
                if !visited[i][j] {
                    if Self::dfs(&grid, &mut visited, i, j, rows, cols, grid[i][j], (i, j)) {
                        return true;
                    }
                }
            }
        }
        false
    }

    fn dfs(
        grid: &Vec<Vec<char>>,
        visited: &mut Vec<Vec<bool>>,
        i: usize,
        j: usize,
        rows: usize,
        cols: usize,
        target: char,
        parent: (usize, usize),
    ) -> bool {
        if grid[i][j] != target {
            return false;
        }
        if visited[i][j] {
            return true;
        }
        visited[i][j] = true;

        let directions = [(-1, 0), (1, 0), (0, -1), (0, 1)];
        for (dx, dy) in directions.iter() {
            let x = i as i32 + dx;
            let y = j as i32 + dy;
            if x >= 0 && x < rows as i32 && y >= 0 && y < cols as i32 {
                let x = x as usize;
                let y = y as usize;
                if (x, y) != parent {
                    if Self::dfs(grid, visited, x, y, rows, cols, target, (i, j)) {
                        return true;
                    }
                }
            }
        }
        false
    }
}