impl Solution {
    pub fn find_max_fish(grid: Vec<Vec<i32>>) -> i32 {
        let m = grid.len();
        let n = grid[0].len();
        let mut visited = vec![vec![false; n]; m];
        let mut max_fish = 0;

        for i in 0..m {
            for j in 0..n {
                if grid[i][j] > 0 && !visited[i][j] {
                    let mut current_fish = 0;
                    let mut stack = vec![(i, j)];
                    visited[i][j] = true;

                    while let Some((row, col)) = stack.pop() {
                        current_fish += grid[row][col];

                        let directions = [(0, 1), (0, -1), (1, 0), (-1, 0)];
                        for &(dr, dc) in &directions {
                            let new_row = row as i32 + dr;
                            let new_col = col as i32 + dc;

                            if new_row >= 0 && new_row < m as i32 && new_col >= 0 && new_col < n as i32 {
                                let new_row = new_row as usize;
                                let new_col = new_col as usize;

                                if grid[new_row][new_col] > 0 && !visited[new_row][new_col] {
                                    stack.push((new_row, new_col));
                                    visited[new_row][new_col] = true;
                                }
                            }
                        }
                    }
                    max_fish = max_fish.max(current_fish);
                }
            }
        }

        max_fish
    }
}