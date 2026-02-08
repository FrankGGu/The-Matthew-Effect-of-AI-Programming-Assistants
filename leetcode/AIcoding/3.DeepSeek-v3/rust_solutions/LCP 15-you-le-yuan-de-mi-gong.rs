use std::collections::{HashSet, VecDeque};

impl Solution {
    pub fn has_valid_path(grid: Vec<Vec<char>>) -> bool {
        let m = grid.len();
        let n = grid[0].len();
        if grid[0][0] == ')' || grid[m - 1][n - 1] == '(' {
            return false;
        }
        let mut visited = HashSet::new();
        let mut queue = VecDeque::new();
        queue.push_back((0, 0, 1));
        visited.insert((0, 0, 1));

        while let Some((i, j, balance)) = queue.pop_front() {
            if i == m - 1 && j == n - 1 && balance == 0 {
                return true;
            }
            if i + 1 < m {
                let new_i = i + 1;
                let new_j = j;
                let new_balance = balance + if grid[new_i][new_j] == '(' { 1 } else { -1 };
                if new_balance >= 0 && !visited.contains(&(new_i, new_j, new_balance)) {
                    visited.insert((new_i, new_j, new_balance));
                    queue.push_back((new_i, new_j, new_balance));
                }
            }
            if j + 1 < n {
                let new_i = i;
                let new_j = j + 1;
                let new_balance = balance + if grid[new_i][new_j] == '(' { 1 } else { -1 };
                if new_balance >= 0 && !visited.contains(&(new_i, new_j, new_balance)) {
                    visited.insert((new_i, new_j, new_balance));
                    queue.push_back((new_i, new_j, new_balance));
                }
            }
        }
        false
    }
}