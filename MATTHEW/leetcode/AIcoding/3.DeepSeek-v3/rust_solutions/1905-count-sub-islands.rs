impl Solution {
    pub fn count_sub_islands(grid1: Vec<Vec<i32>>, grid2: Vec<Vec<i32>>) -> i32 {
        let mut grid2 = grid2;
        let rows = grid2.len();
        if rows == 0 {
            return 0;
        }
        let cols = grid2[0].len();
        let mut count = 0;

        for i in 0..rows {
            for j in 0..cols {
                if grid2[i][j] == 1 && Self::dfs(&grid1, &mut grid2, i, j, rows, cols) {
                    count += 1;
                }
            }
        }

        count
    }

    fn dfs(grid1: &Vec<Vec<i32>>, grid2: &mut Vec<Vec<i32>>, i: usize, j: usize, rows: usize, cols: usize) -> bool {
        if i >= rows || j >= cols || grid2[i][j] == 0 {
            return true;
        }

        grid2[i][j] = 0;
        let mut res = grid1[i][j] == 1;

        if i > 0 {
            res &= Self::dfs(grid1, grid2, i - 1, j, rows, cols);
        }
        if j > 0 {
            res &= Self::dfs(grid1, grid2, i, j - 1, rows, cols);
        }
        if i < rows - 1 {
            res &= Self::dfs(grid1, grid2, i + 1, j, rows, cols);
        }
        if j < cols - 1 {
            res &= Self::dfs(grid1, grid2, i, j + 1, rows, cols);
        }

        res
    }
}