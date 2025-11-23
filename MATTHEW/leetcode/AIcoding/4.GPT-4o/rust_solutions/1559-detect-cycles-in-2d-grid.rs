impl Solution {
    pub fn contains_cycle(grid: Vec<Vec<char>>) -> bool {
        let rows = grid.len();
        let cols = grid[0].len();
        let mut visited = vec![vec![false; cols]; rows];
        let directions = vec![(1, 0), (-1, 0), (0, 1), (0, -1)];

        let mut dfs = |r: usize, c: usize, prev_r: isize, prev_c: isize, char: char| -> bool {
            if visited[r][c] {
                return true;
            }
            visited[r][c] = true;
            for (dr, dc) in &directions {
                let new_r = r as isize + dr;
                let new_c = c as isize + dc;
                if new_r >= 0 && new_r < rows as isize && new_c >= 0 && new_c < cols as isize {
                    if !(new_r as usize == prev_r as usize && new_c as usize == prev_c as usize) && grid[new_r as usize][new_c as usize] == char {
                        if dfs(new_r as usize, new_c as usize, r as isize, c as isize, char) {
                            return true;
                        }
                    }
                }
            }
            false
        };

        for r in 0..rows {
            for c in 0..cols {
                if !visited[r][c] {
                    if dfs(r, c, -1, -1, grid[r][c]) {
                        return true;
                    }
                }
            }
        }
        false
    }
}