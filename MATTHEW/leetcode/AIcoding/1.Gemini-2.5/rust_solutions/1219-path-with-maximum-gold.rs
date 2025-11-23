struct Solution;

impl Solution {
    fn dfs(grid: &mut Vec<Vec<i32>>, r: usize, c: usize, rows: usize, cols: usize) -> i32 {
        if r >= rows || c >= cols || grid[r][c] == 0 {
            return 0;
        }

        let current_gold = grid[r][c];
        grid[r][c] = 0; // Mark as visited by setting gold to 0

        let mut max_path_gold = 0;
        let dr = [-1, 1, 0, 0];
        let dc = [0, 0, -1, 1];

        for i in 0..4 {
            let nr = r as i32 + dr[i];
            let nc = c as i32 + dc[i];

            if nr >= 0 && nr < rows as i32 && nc >= 0 && nc < cols as i32 {
                max_path_gold = max_path_gold.max(Self::dfs(grid, nr as usize, nc as usize, rows, cols));
            }
        }

        grid[r][c] = current_gold; // Backtrack: restore original gold value
        current_gold + max_path_gold
    }

    pub fn get_maximum_gold(mut grid: Vec<Vec<i32>>) -> i32 {
        let rows = grid.len();
        if rows == 0 {
            return 0;
        }
        let cols = grid[0].len();
        if cols == 0 {
            return 0;
        }

        let mut overall_max_gold = 0;

        for r in 0..rows {
            for c in 0..cols {
                if grid[r][c] > 0 {
                    overall_max_gold = overall_max_gold.max(Self::dfs(&mut grid, r, c, rows, cols));
                }
            }
        }

        overall_max_gold
    }
}