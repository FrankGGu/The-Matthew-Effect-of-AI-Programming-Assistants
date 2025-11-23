impl Solution {
    pub fn rotate_grid(grid: Vec<Vec<i32>>, k: i32) -> Vec<Vec<i32>> {
        let (m, n) = (grid.len(), grid[0].len());
        let layers = (m.min(n) + 1) / 2;
        let mut result = grid.clone();

        for layer in 0..layers {
            let mut elements = Vec::new();
            let rows = m - 2 * layer;
            let cols = n - 2 * layer;

            for j in 0..cols {
                elements.push(grid[layer][layer + j]);
            }
            for i in 1..rows {
                elements.push(grid[layer + i][n - 1 - layer]);
            }
            for j in (0..cols - 1).rev() {
                elements.push(grid[m - 1 - layer][layer + j]);
            }
            for i in (1..rows - 1).rev() {
                elements.push(grid[layer + i][layer]);
            }

            let len = elements.len();
            let k = k as usize % len;

            for j in 0..cols {
                result[layer][layer + j] = elements[(j + len - k) % len];
            }
            for i in 1..rows {
                result[layer + i][n - 1 - layer] = elements[(cols + i + len - k) % len];
            }
            for j in (0..cols - 1).rev() {
                result[m - 1 - layer][layer + j] = elements[(cols + rows - 1 + (cols - 1 - j) + len - k) % len];
            }
            for i in (1..rows - 1).rev() {
                result[layer + i][layer] = elements[(cols + rows - 1 + cols + (rows - 1 - i) + len - k) % len];
            }
        }
        result
    }
}