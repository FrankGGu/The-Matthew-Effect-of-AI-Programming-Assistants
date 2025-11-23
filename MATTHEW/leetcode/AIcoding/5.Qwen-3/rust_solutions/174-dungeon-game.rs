impl Solution {

use std::cmp::min;

#[derive(Debug, Clone, Copy, PartialEq, Eq)]
struct Cell {
    hp: i32,
}

impl Cell {
    fn new(hp: i32) -> Self {
        Cell { hp }
    }
}

fn calculateMinimumHP(dungeon: Vec<Vec<i32>>) -> i32 {
    let rows = dungeon.len();
    let cols = dungeon[0].len();

    let mut dp = vec![vec![0; cols]; rows];

    for i in (0..rows).rev() {
        for j in (0..cols).rev() {
            if i == rows - 1 && j == cols - 1 {
                dp[i][j] = min(1, 1 + dungeon[i][j]);
            } else if i == rows - 1 {
                dp[i][j] = min(1, dp[i][j + 1] + dungeon[i][j]);
            } else if j == cols - 1 {
                dp[i][j] = min(1, dp[i + 1][j] + dungeon[i][j]);
            } else {
                dp[i][j] = min(
                    1,
                    min(dp[i][j + 1], dp[i + 1][j]) + dungeon[i][j],
                );
            }
        }
    }

    dp[0][0]
}
}