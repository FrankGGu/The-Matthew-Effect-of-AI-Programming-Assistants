impl Solution {
    pub fn color_border(grid: Vec<Vec<i32>>, row: i32, col: i32, color: i32) -> Vec<Vec<i32>> {
        let m = grid.len();
        if m == 0 {
            return grid;
        }
        let n = grid[0].len();
        let mut grid = grid;
        let original_color = grid[row as usize][col as usize];
        if original_color == color {
            return grid;
        }
        let mut visited = vec![vec![false; n]; m];
        let mut borders = Vec::new();
        Self::dfs(&mut grid, &mut visited, row as usize, col as usize, original_color, &mut borders);
        for (i, j) in borders {
            grid[i][j] = color;
        }
        grid
    }

    fn dfs(grid: &mut Vec<Vec<i32>>, visited: &mut Vec<Vec<bool>>, i: usize, j: usize, original_color: i32, borders: &mut Vec<(usize, usize)>) {
        visited[i][j] = true;
        let m = grid.len();
        let n = grid[0].len();
        let mut is_border = false;
        let dirs = [(-1, 0), (1, 0), (0, -1), (0, 1)];
        for (dx, dy) in dirs.iter() {
            let x = i as i32 + dx;
            let y = j as i32 + dy;
            if x < 0 || x >= m as i32 || y < 0 || y >= n as i32 || grid[x as usize][y as usize] != original_color {
                is_border = true;
            } else if !visited[x as usize][y as usize] {
                Self::dfs(grid, visited, x as usize, y as usize, original_color, borders);
            }
        }
        if is_border {
            borders.push((i, j));
        }
    }
}