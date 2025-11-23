impl Solution {
    pub fn spiral_matrix(rows: i32, cols: i32, r_start: i32, c_start: i32) -> Vec<Vec<i32>> {
        let mut result: Vec<Vec<i32>> = Vec::new();
        let mut r = r_start;
        let mut c = c_start;
        let mut dx = 0;
        let mut dy = 1;
        let mut step = 1;
        let mut count = 0;

        while count < (rows * cols) as usize {
            if r >= 0 && r < rows && c >= 0 && c < cols {
                result.push(vec![r, c]);
                count += 1;
            }

            c += dy;
            r += dx;

            if dy == 1 && dx == 0 {
                if c - c_start == step {
                    dy = 0;
                    dx = 1;
                }
            } else if dy == 0 && dx == 1 {
                if r - r_start == step {
                    dy = -1;
                    dx = 0;
                    step += 1;
                }
            } else if dy == -1 && dx == 0 {
                if c_start - c == step {
                    dy = 0;
                    dx = -1;
                }
            } else if dy == 0 && dx == -1 {
                if r_start - r == step {
                    dy = 1;
                    dx = 0;
                    step += 1;
                }
            }
        }

        result
    }
}