impl Solution {
    pub fn max_area_of_island(mut grid: Vec<Vec<i32>>) -> i32 {
        let rows = grid.len();
        if rows == 0 {
            return 0;
        }
        let cols = grid[0].len();
        if cols == 0 {
            return 0;
        }

        let mut max_area = 0;

        for r in 0..rows {
            for c in 0..cols {
                if grid[r][c] == 1 {
                    let current_island_area = Self::dfs(&mut grid, r, c, rows, cols);
                    max_area = max_area.max(current_island_area);
                }
            }
        }
        max_area
    }

    fn dfs(grid: &mut Vec<Vec<i32>>, r: usize, c: usize, rows: usize, cols: usize) -> i32 {
        if r >= rows || c >= cols || grid[r][c] == 0 {
            return 0;
        }

        grid[r][c] = 0;
        let mut current_area = 1;

        let dr = [-1, 1, 0, 0];
        let dc = [0, 0, -1, 1];

        for i in 0..4 {
            let nr = r as isize + dr[i];
            let nc = c as isize + dc[i];

            if nr >= 0 && nr < rows as isize && nc >= 0 && nc < cols as isize {
                current_area += Self::dfs(grid, nr as usize, nc as usize, rows, cols);
            }
        }

        current_area
    }
}