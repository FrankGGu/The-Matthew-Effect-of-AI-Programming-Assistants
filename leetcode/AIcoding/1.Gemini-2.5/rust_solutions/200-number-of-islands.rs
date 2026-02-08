impl Solution {
    pub fn num_islands(mut grid: Vec<Vec<char>>) -> i32 {
        let rows = grid.len();
        if rows == 0 {
            return 0;
        }
        let cols = grid[0].len();
        if cols == 0 {
            return 0;
        }

        let mut num_islands = 0;

        for r in 0..rows {
            for c in 0..cols {
                if grid[r][c] == '1' {
                    num_islands += 1;
                    Self::dfs(&mut grid, r, c, rows, cols);
                }
            }
        }

        num_islands
    }

    fn dfs(grid: &mut Vec<Vec<char>>, r: usize, c: usize, rows: usize, cols: usize) {
        if r >= rows || c >= cols || grid[r][c] == '0' {
            return;
        }

        grid[r][c] = '0'; // Mark as visited

        let dr = [-1, 1, 0, 0];
        let dc = [0, 0, -1, 1];

        for i in 0..4 {
            let nr = r as isize + dr[i];
            let nc = c as isize + dc[i];

            if nr >= 0 && nr < rows as isize && nc >= 0 && nc < cols as isize {
                Self::dfs(grid, nr as usize, nc as usize, rows, cols);
            }
        }
    }
}