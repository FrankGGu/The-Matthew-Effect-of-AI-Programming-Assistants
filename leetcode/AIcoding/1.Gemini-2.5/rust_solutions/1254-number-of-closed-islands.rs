impl Solution {
    pub fn closed_island(mut grid: Vec<Vec<i32>>) -> i32 {
        let rows = grid.len();
        if rows == 0 {
            return 0;
        }
        let cols = grid[0].len();
        if cols == 0 {
            return 0;
        }

        let mut dfs = |r: usize, c: usize, grid: &mut Vec<Vec<i32>>| {
            let mut stack = vec![(r, c)];
            while let Some((curr_r, curr_c)) = stack.pop() {
                if curr_r >= rows || curr_c >= cols || grid[curr_r][curr_c] == 1 {
                    continue;
                }
                grid[curr_r][curr_c] = 1;

                if curr_r > 0 {
                    stack.push((curr_r - 1, curr_c));
                }
                if curr_r < rows - 1 {
                    stack.push((curr_r + 1, curr_c));
                }
                if curr_c > 0 {
                    stack.push((curr_r, curr_c - 1));
                }
                if curr_c < cols - 1 {
                    stack.push((curr_r, curr_c + 1));
                }
            }
        };

        for c in 0..cols {
            if grid[0][c] == 0 {
                dfs(0, c, &mut grid);
            }
            if grid[rows - 1][c] == 0 {
                dfs(rows - 1, c, &mut grid);
            }
        }

        for r in 0..rows {
            if grid[r][0] == 0 {
                dfs(r, 0, &mut grid);
            }
            if grid[r][cols - 1] == 0 {
                dfs(r, cols - 1, &mut grid);
            }
        }

        let mut closed_islands_count = 0;

        for r in 0..rows {
            for c in 0..cols {
                if grid[r][c] == 0 {
                    closed_islands_count += 1;
                    dfs(r, c, &mut grid);
                }
            }
        }

        closed_islands_count
    }
}