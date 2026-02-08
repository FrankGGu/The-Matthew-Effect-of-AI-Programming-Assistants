use std::collections::HashSet;

impl Solution {
    pub fn difference_of_distinct_values(grid: Vec<Vec<i32>>) -> Vec<Vec<i32>> {
        let m = grid.len();
        let n = grid[0].len();
        let mut result = vec![vec![0; n]; m];

        for i in 0..m {
            for j in 0..n {
                let mut top_left = HashSet::new();
                let mut bottom_right = HashSet::new();

                let mut row = i - 1;
                let mut col = j - 1;
                while row >= 0 && col >= 0 {
                    top_left.insert(grid[row as usize][col as usize]);
                    row -= 1;
                    col -= 1;
                }

                let mut row = i + 1;
                let mut col = j + 1;
                while row < m && col < n {
                    bottom_right.insert(grid[row][col]);
                    row += 1;
                    col += 1;
                }

                result[i][j] = (top_left.len() as i32 - bottom_right.len() as i32).abs();
            }
        }

        result
    }
}