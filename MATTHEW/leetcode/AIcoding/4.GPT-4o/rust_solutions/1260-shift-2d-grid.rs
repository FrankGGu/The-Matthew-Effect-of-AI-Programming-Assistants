impl Solution {
    pub fn shift_grid(grid: Vec<Vec<i32>>, k: i32) -> Vec<Vec<i32>> {
        let (rows, cols) = (grid.len(), grid[0].len());
        let total_cells = rows * cols;
        let k = k % total_cells;
        let mut result = vec![vec![0; cols]; rows];

        for i in 0..rows {
            for j in 0..cols {
                let new_pos = (i * cols + j + k) % total_cells;
                let new_i = new_pos / cols;
                let new_j = new_pos % cols;
                result[new_i][new_j] = grid[i][j];
            }
        }

        result
    }
}