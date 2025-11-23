impl Solution {

use std::collections::{HashSet, VecDeque};

impl Solution {
    pub fn earliest_day(mut grid: Vec<Vec<i32>>) -> i32 {
        let rows = grid.len();
        let cols = grid[0].len();

        let mut left = 0;
        let mut right = rows * cols;

        while left < right {
            let mid = left + (right - left) / 2;
            let mut temp_grid = grid.clone();
            for i in 0..rows {
                for j in 0..cols {
                    if temp_grid[i][j] <= mid {
                        temp_grid[i][j] = 1;
                    } else {
                        temp_grid[i][j] = 0;
                    }
                }
            }

            if Self::can_cross(&temp_grid) {
                left = mid + 1;
            } else {
                right = mid;
            }
        }

        left
    }

    fn can_cross(grid: &Vec<Vec<i32>>) -> bool {
        let rows = grid.len();
        let cols = grid[0].len();

        let mut visited = vec![vec![false; cols]; rows];
        let mut queue = VecDeque::new();

        for j in 0..cols {
            if grid[0][j] == 1 {
                visited[0][j] = true;
                queue.push_back((0, j));
            }
        }

        let directions = [(-1, 0), (1, 0), (0, -1), (0, 1)];

        while let Some((i, j)) = queue.pop_front() {
            if i == rows - 1 {
                return true;
            }

            for &(dx, dy) in &directions {
                let ni = i as i32 + dx;
                let nj = j as i32 + dy;
                if ni >= 0 && ni < rows as i32 && nj >= 0 && nj < cols as i32 {
                    let ni = ni as usize;
                    let nj = nj as usize;
                    if !visited[ni][nj] && grid[ni][nj] == 1 {
                        visited[ni][nj] = true;
                        queue.push_back((ni, nj));
                    }
                }
            }
        }

        false
    }
}
}