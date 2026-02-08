use std::cmp::min;

impl Solution {
    pub fn rotate_grid(mut grid: Vec<Vec<i32>>, k: i32) -> Vec<Vec<i32>> {
        let m = grid.len();
        let n = grid[0].len();

        // The number of concentric rectangular layers is min(m, n) / 2.
        // Layers are indexed from 0 outwards.
        let num_layers = min(m, n) / 2;

        for l in 0..num_layers {
            // Define the boundaries for the current layer
            let top = l;
            let bottom = m - 1 - l;
            let left = l;
            let right = n - 1 - l;

            let mut layer_elements = Vec::new();

            // Extract elements from the current layer in clockwise order
            // 1. Top row (from left to right)
            for c in left..=right {
                layer_elements.push(grid[top][c]);
            }
            // 2. Right column (from top+1 to bottom)
            for r in (top + 1)..=bottom {
                layer_elements.push(grid[r][right]);
            }
            // 3. Bottom row (from right-1 to left, if it's a distinct row from top)
            if top != bottom {
                for c in (left..right).rev() { // Iterate from right-1 down to left
                    layer_elements.push(grid[bottom][c]);
                }
            }
            // 4. Left column (from bottom-1 to top+1, if it's a distinct column from right)
            if left != right {
                for r in (top + 1..bottom).rev() { // Iterate from bottom-1 down to top+1
                    layer_elements.push(grid[r][left]);
                }
            }

            let layer_size = layer_elements.len();
            if layer_size == 0 {
                // This case should not be reached if num_layers is calculated correctly for m, n >= 1.
                // It acts as a safeguard.
                continue;
            }

            // Calculate the actual rotation amount
            let actual_k = (k % layer_size as i32) as usize;

            // Rotate the extracted elements
            layer_elements.rotate_left(actual_k);

            // Place the rotated elements back into the grid in clockwise order
            let mut idx = 0;
            // 1. Top row
            for c in left..=right {
                grid[top][c] = layer_elements[idx];
                idx += 1;
            }
            // 2. Right column
            for r in (top + 1)..=bottom {
                grid[r][right] = layer_elements[idx];
                idx += 1;
            }
            // 3. Bottom row
            if top != bottom {
                for c in (left..right).rev() {
                    grid[bottom][c] = layer_elements[idx];
                    idx += 1;
                }
            }
            // 4. Left column
            if left != right {
                for r in (top + 1..bottom).rev() {
                    grid[r][left] = layer_elements[idx];
                    idx += 1;
                }
            }
        }

        grid
    }
}