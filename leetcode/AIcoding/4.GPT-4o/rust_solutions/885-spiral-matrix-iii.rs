impl Solution {
    pub fn spiral_matrixIII(rows: i32, cols: i32, r_start: i32, c_start: i32) -> Vec<Vec<i32>> {
        let mut result = Vec::new();
        let directions = vec![(0, 1), (1, 0), (0, -1), (-1, 0)];
        let mut x = r_start;
        let mut y = c_start;
        let mut step = 0;
        let mut dir = 0;

        for _ in 0..(rows * cols) {
            if x >= 0 && x < rows && y >= 0 && y < cols {
                result.push(vec![x, y]);
            }

            if dir % 2 == 0 {
                step += 1;
            }

            let (dx, dy) = directions[dir % 4];
            x += dx;
            y += dy;

            if result.len() == step {
                dir += 1;
            }
        }
        result
    }
}