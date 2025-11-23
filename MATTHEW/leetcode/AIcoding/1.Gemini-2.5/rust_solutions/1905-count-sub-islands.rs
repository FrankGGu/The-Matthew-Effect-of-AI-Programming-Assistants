impl Solution {
    pub fn count_sub_islands(mut grid1: Vec<Vec<i32>>, mut grid2: Vec<Vec<i32>>) -> i32 {
        let rows = grid1.len() as i32;
        let cols = grid1[0].len() as i32;
        let mut sub_island_count = 0;

        for r in 0..rows {
            for c in 0..cols {
                if grid2[r as usize][c as usize] == 1 {
                    if Self::dfs_check(r, c, &grid1, &mut grid2, rows, cols) {
                        sub_island_count += 1;
                    }
                }
            }
        }
        sub_island_count
    }

    fn dfs_check(r: i32, c: i32, grid1: &Vec<Vec<i32>>, grid2: &mut Vec<Vec<i32>>, rows: i32, cols: i32) -> bool {
        if r < 0 || r >= rows || c < 0 || c >= cols || grid2[r as usize][c as usize] == 0 {
            return true;
        }

        grid2[r as usize][c as usize] = 0;

        let mut is_current_cell_valid = grid1[r as usize][c as usize] == 1;

        is_current_cell_valid = is_current_cell_valid && Self::dfs_check(r + 1, c, grid1, grid2, rows, cols);
        is_current_cell_valid = is_current_cell_valid && Self::dfs_check(r - 1, c, grid1, grid2, rows, cols);
        is_current_cell_valid = is_current_cell_valid && Self::dfs_check(r, c + 1, grid1, grid2, rows, cols);
        is_current_cell_valid = is_current_cell_valid && Self::dfs_check(r, c - 1, grid1, grid2, rows, cols);

        is_current_cell_valid
    }
}