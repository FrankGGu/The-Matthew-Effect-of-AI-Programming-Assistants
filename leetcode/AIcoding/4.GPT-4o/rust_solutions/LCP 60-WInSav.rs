pub fn find_balls(grid: Vec<Vec<i32>>) -> Vec<i32> {
    let m = grid.len();
    let n = grid[0].len();
    let mut result = vec![0; n];

    for j in 0..n {
        let mut col = j;
        for i in 0..m {
            if grid[i][col] == 1 {
                if col + 1 < n && grid[i][col + 1] == 1 {
                    col += 1;
                } else {
                    col = -1;
                    break;
                }
            } else {
                if col > 0 && grid[i][col - 1] == -1 {
                    col -= 1;
                } else {
                    col = -1;
                    break;
                }
            }
        }
        result[j] = if col == -1 { -1 } else { col as i32 };
    }
    result
}