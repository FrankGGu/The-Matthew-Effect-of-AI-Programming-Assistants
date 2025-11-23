use std::cmp::min;
use std::collections::BinaryHeap;

#[derive(PartialEq, Eq, PartialOrd, Ord)]
struct Cell {
    height: i32,
    row: usize,
    col: usize,
}

impl Solution {
    pub fn trap_rain_water(heights: Vec<Vec<i32>>) -> i32 {
        if heights.is_empty() || heights[0].is_empty() {
            return 0;
        }

        let m = heights.len();
        let n = heights[0].len();
        let mut visited = vec![vec![false; n]; m];
        let mut heap = BinaryHeap::new();

        for i in 0..m {
            heap.push(Cell { height: heights[i][0], row: i, col: 0 });
            visited[i][0] = true;
            heap.push(Cell { height: heights[i][n - 1], row: i, col: n - 1 });
            visited[i][n - 1] = true;
        }

        for j in 1..n - 1 {
            heap.push(Cell { height: heights[0][j], row: 0, col: j });
            visited[0][j] = true;
            heap.push(Cell { height: heights[m - 1][j], row: m - 1, col: j });
            visited[m - 1][j] = true;
        }

        let mut water = 0;
        let directions = [(0, 1), (0, -1), (1, 0), (-1, 0)];

        while let Some(Cell { height, row, col }) = heap.pop() {
            for &(dr, dc) in &directions {
                let new_row = row as i32 + dr;
                let new_col = col as i32 + dc;

                if new_row >= 0 && new_row < m as i32 && new_col >= 0 && new_col < n as i32 {
                    let new_row = new_row as usize;
                    let new_col = new_col as usize;

                    if !visited[new_row][new_col] {
                        visited[new_row][new_col] = true;
                        water += (0).max(height - heights[new_row][new_col]);
                        heap.push(Cell {
                            height: (height).max(heights[new_row][new_col]),
                            row: new_row,
                            col: new_col,
                        });
                    }
                }
            }
        }

        water
    }
}