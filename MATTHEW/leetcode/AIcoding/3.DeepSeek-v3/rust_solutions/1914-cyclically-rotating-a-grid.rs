impl Solution {
    pub fn rotate_grid(grid: Vec<Vec<i32>>, k: i32) -> Vec<Vec<i32>> {
        let m = grid.len();
        let n = grid[0].len();
        let mut result = grid.clone();
        let layers = std::cmp::min(m, n) / 2;

        for layer in 0..layers {
            let mut elements = Vec::new();
            let top = layer;
            let bottom = m - 1 - layer;
            let left = layer;
            let right = n - 1 - layer;

            for i in left..right {
                elements.push(result[top][i]);
            }
            for i in top..bottom {
                elements.push(result[i][right]);
            }
            for i in (left + 1..=right).rev() {
                elements.push(result[bottom][i]);
            }
            for i in (top + 1..=bottom).rev() {
                elements.push(result[i][left]);
            }

            let len = elements.len();
            let k = (k as usize) % len;
            let rotated = [&elements[k..], &elements[..k]].concat();

            let mut index = 0;
            for i in left..right {
                result[top][i] = rotated[index];
                index += 1;
            }
            for i in top..bottom {
                result[i][right] = rotated[index];
                index += 1;
            }
            for i in (left + 1..=right).rev() {
                result[bottom][i] = rotated[index];
                index += 1;
            }
            for i in (top + 1..=bottom).rev() {
                result[i][left] = rotated[index];
                index += 1;
            }
        }

        result
    }
}