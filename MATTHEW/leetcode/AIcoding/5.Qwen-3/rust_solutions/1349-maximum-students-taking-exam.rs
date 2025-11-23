impl Solution {

use std::collections::HashSet;

impl Solution {
    pub fn max_students(rooms: Vec<Vec<char>>) -> i32 {
        fn dfs(
            rooms: &Vec<Vec<char>>,
            row: usize,
            col: usize,
            visited: &mut HashSet<usize>,
            dp: &mut Vec<Vec<i32>>,
        ) -> i32 {
            if row >= rooms.len() {
                return 0;
            }
            let idx = row * rooms[0].len() + col;
            if visited.contains(&idx) {
                return dp[row][col];
            }
            let mut res = 0;
            if rooms[row][col] == '.' {
                let mut can_place = true;
                if col > 0 && rooms[row][col - 1] == 's' {
                    can_place = false;
                }
                if col < rooms[0].len() - 1 && rooms[row][col + 1] == 's' {
                    can_place = false;
                }
                if row > 0 {
                    if col > 0 && rooms[row - 1][col - 1] == 's' {
                        can_place = false;
                    }
                    if rooms[row - 1][col] == 's' {
                        can_place = false;
                    }
                    if col < rooms[0].len() - 1 && rooms[row - 1][col + 1] == 's' {
                        can_place = false;
                    }
                }
                if can_place {
                    visited.insert(idx);
                    let next_row = if col == rooms[0].len() - 1 { row + 1 } else { row };
                    let next_col = if col == rooms[0].len() - 1 { 0 } else { col + 1 };
                    res = 1 + dfs(rooms, next_row, next_col, visited, dp);
                    visited.remove(&idx);
                }
            }
            let next_row = if col == rooms[0].len() - 1 { row + 1 } else { row };
            let next_col = if col == rooms[0].len() - 1 { 0 } else { col + 1 };
            res = res.max(dfs(rooms, next_row, next_col, visited, dp));
            dp[row][col] = res;
            res
        }

        let m = rooms.len();
        let n = rooms[0].len();
        let mut dp = vec![vec![-1; n]; m];
        let mut visited = HashSet::new();
        dfs(&rooms, 0, 0, &mut visited, &mut dp)
    }
}
}