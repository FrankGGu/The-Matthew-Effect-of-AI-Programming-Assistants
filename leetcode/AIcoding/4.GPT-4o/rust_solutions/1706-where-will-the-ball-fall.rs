pub fn find_ball(grid: Vec<Vec<i32>>) -> Vec<i32> {
    let mut result = vec![-1; grid[0].len()];

    for j in 0..grid[0].len() {
        let mut col = j;
        for i in 0..grid.len() {
            let dir = grid[i][col];
            if dir == 1 {
                if col == grid[0].len() - 1 || grid[i][col + 1] == -1 {
                    col = -1;
                    break;
                }
                col += 1;
            } else {
                if col == 0 || grid[i][col - 1] == 1 {
                    col = -1;
                    break;
                }
                col -= 1;
            }
        }
        result[j] = col;
    }

    result
}