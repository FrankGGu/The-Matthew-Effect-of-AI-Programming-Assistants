pub fn longest_v_shaped_segment(grid: Vec<Vec<i32>>) -> i32 {
    let mut max_length = 0;
    let rows = grid.len();
    if rows == 0 { return 0; }
    let cols = grid[0].len();

    for r in 0..rows {
        for c in 0..cols {
            if grid[r][c] == 1 {
                let mut length = 1;
                let mut up = r;
                let mut down = r;

                while up > 0 && down < rows - 1 && grid[up - 1][c] == 1 && grid[down + 1][c] == 1 {
                    length += 2;
                    up -= 1;
                    down += 1;
                }
                max_length = max_length.max(length);
            }
        }
    }
    max_length
}