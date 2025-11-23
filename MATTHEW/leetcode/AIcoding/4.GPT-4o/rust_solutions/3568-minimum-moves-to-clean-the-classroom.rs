pub fn minimum_moves(grid: Vec<Vec<i32>>) -> i32 {
    let n = grid.len();
    let m = grid[0].len();
    let mut dp = vec![vec![i32::MAX; m]; n];
    dp[0][0] = 0;

    for i in 0..n {
        for j in 0..m {
            if dp[i][j] == i32::MAX {
                continue;
            }
            let mut moves = 0;
            for x in i..n {
                for y in j..m {
                    if grid[x][y] == 1 {
                        moves += 1;
                    }
                    dp[x][y] = dp[x][y].min(dp[i][j] + moves);
                }
            }
        }
    }
    dp[n - 1][m - 1]
}