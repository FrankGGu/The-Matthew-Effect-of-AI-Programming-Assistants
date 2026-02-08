impl Solution {
    pub fn rotate_grid(grid: Vec<Vec<i32>>, k: i32) -> Vec<Vec<i32>> {
        let mut result = grid.clone();
        let m = grid.len();
        let n = grid[0].len();
        let layers = std::cmp::min(m, n) / 2;

        for layer in 0..layers {
            let mut perimeter = 2 * (m - 2 * layer) + 2 * (n - 2 * layer) - 4;
            let rotations = k % perimeter as i32;

            let mut values = Vec::new();
            // Extract values
            for j in layer..n - layer {
                values.push(grid[layer][j]);
            }
            for i in layer + 1..m - layer {
                values.push(grid[i][n - layer - 1]);
            }
            for j in (layer..n - layer - 1).rev() {
                values.push(grid[m - layer - 1][j]);
            }
            for i in (layer + 1..m - layer - 1).rev() {
                values.push(grid[i][layer]);
            }

            // Rotate values
            let mut rotated_values = values.clone();
            for i in 0..values.len() {
                rotated_values[(i + rotations as usize) % values.len()] = values[i];
            }

            // Place rotated values back into result
            let mut index = 0;
            for j in layer..n - layer {
                result[layer][j] = rotated_values[index];
                index += 1;
            }
            for i in layer + 1..m - layer {
                result[i][n - layer - 1] = rotated_values[index];
                index += 1;
            }
            for j in (layer..n - layer - 1).rev() {
                result[m - layer - 1][j] = rotated_values[index];
                index += 1;
            }
            for i in (layer + 1..m - layer - 1).rev() {
                result[i][layer] = rotated_values[index];
                index += 1;
            }
        }

        result
    }
}