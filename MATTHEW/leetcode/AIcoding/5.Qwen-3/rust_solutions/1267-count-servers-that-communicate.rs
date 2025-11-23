impl Solution {

use std::collections::HashMap;

#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub struct Server {
    pub id: i32,
    pub ip: String,
}

#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub struct Connection {
    pub src: i32,
    pub dst: i32,
}

pub struct Solution;

impl Solution {
    pub fn count_servers(grid: Vec<Vec<i32>>) -> i32 {
        let rows = grid.len();
        let cols = if rows > 0 { grid[0].len() } else { 0 };

        let mut row_count = vec![0; rows];
        let mut col_count = vec![0; cols];

        for i in 0..rows {
            for j in 0..cols {
                if grid[i][j] == 1 {
                    row_count[i] += 1;
                    col_count[j] += 1;
                }
            }
        }

        let mut result = 0;
        for i in 0..rows {
            for j in 0..cols {
                if grid[i][j] == 1 && (row_count[i] > 1 || col_count[j] > 1) {
                    result += 1;
                }
            }
        }

        result
    }
}
}