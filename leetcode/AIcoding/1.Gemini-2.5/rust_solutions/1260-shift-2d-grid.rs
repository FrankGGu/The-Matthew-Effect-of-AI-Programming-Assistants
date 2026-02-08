impl Solution {
    pub fn shift_grid(grid: Vec<Vec<i32>>, k: i32) -> Vec<Vec<i32>> {
        let rows = grid.len();
        let cols = grid[0].len();

        let total_elements = rows * cols;

        // If the grid is empty, or if k is a multiple of total_elements,
        // the grid effectively remains unchanged.
        // However, problem constraints state 1 <= m, n <= 50, so total_elements >= 1.
        if total_elements == 0 {
            return vec![];
        }

        let k_effective = (k as usize) % total_elements;

        let mut shifted_grid = vec![vec![0; cols]; rows];

        for r in 0..rows {
            for c in 0..cols {
                // Calculate the 1D index of the current element in the original grid
                let original_flat_idx = r * cols + c;

                // Calculate the 1D index where this element will move in the shifted grid
                let new_flat_idx = (original_flat_idx + k_effective) % total_elements;

                // Convert the new 1D index back to 2D coordinates
                let new_r = new_flat_idx / cols;
                let new_c = new_flat_idx % cols;

                // Place the element from the original grid into its new position
                shifted_grid[new_r][new_c] = grid[r][c];
            }
        }

        shifted_grid
    }
}