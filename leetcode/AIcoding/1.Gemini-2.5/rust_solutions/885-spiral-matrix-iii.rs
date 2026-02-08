impl Solution {
    pub fn spiral_matrix_iii(rows: i32, cols: i32, r_start: i32, c_start: i32) -> Vec<Vec<i32>> {
        let mut result: Vec<Vec<i32>> = Vec::new();
        let total_cells = (rows * cols) as usize;

        let mut r = r_start;
        let mut c = c_start;

        // Directions: Right, Down, Left, Up
        let dr = [0, 1, 0, -1];
        let dc = [1, 0, -1, 0];

        let mut dir_idx = 0; // 0: Right, 1: Down, 2: Left, 3: Up
        let mut step_len = 1;
        let mut segment_count = 0;

        result.push(vec![r, c]);

        while result.len() < total_cells {
            for _ in 0..step_len {
                r += dr[dir_idx];
                c += dc[dir_idx];

                if r >= 0 && r < rows && c >= 0 && c < cols {
                    result.push(vec![r, c]);
                }

                if result.len() == total_cells {
                    return result;
                }
            }

            dir_idx = (dir_idx + 1) % 4;
            segment_count += 1;

            if segment_count % 2 == 0 {
                step_len += 1;
            }
        }

        result
    }
}