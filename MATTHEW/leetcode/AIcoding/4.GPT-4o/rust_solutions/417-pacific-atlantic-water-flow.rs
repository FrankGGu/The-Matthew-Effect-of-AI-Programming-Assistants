use std::collections::HashSet;

impl Solution {
    pub fn pacific_atlantic(heights: Vec<Vec<i32>>) -> Vec<Vec<i32>> {
        if heights.is_empty() || heights[0].is_empty() {
            return vec![];
        }

        let rows = heights.len();
        let cols = heights[0].len();
        let mut pacific = vec![vec![false; cols]; rows];
        let mut atlantic = vec![vec![false; cols]; rows];
        let mut result = vec![];

        let directions = vec![(0, 1), (1, 0), (0, -1), (-1, 0)];

        fn dfs(heights: &Vec<Vec<i32>>, visited: &mut Vec<Vec<bool>>, row: usize, col: usize) {
            let rows = heights.len();
            let cols = heights[0].len();
            visited[row][col] = true;

            for (dr, dc) in &directions {
                let new_row = (row as isize + dr) as usize;
                let new_col = (col as isize + dc) as usize;

                if new_row < rows && new_col < cols && !visited[new_row][new_col] && heights[new_row][new_col] >= heights[row][col] {
                    dfs(heights, visited, new_row, new_col);
                }
            }
        }

        for i in 0..rows {
            dfs(&heights, &mut pacific, i, 0);
            dfs(&heights, &mut atlantic, i, cols - 1);
        }

        for j in 0..cols {
            dfs(&heights, &mut pacific, 0, j);
            dfs(&heights, &mut atlantic, rows - 1, j);
        }

        for i in 0..rows {
            for j in 0..cols {
                if pacific[i][j] && atlantic[i][j] {
                    result.push(vec![i as i32, j as i32]);
                }
            }
        }

        result
    }
}