struct Solution;

impl Solution {
    pub fn min_days(mut grid: Vec<Vec<i32>>) -> i32 {
        let m = grid.len();
        let n = grid[0].len();

        let count_components = |current_grid: &Vec<Vec<i32>>| -> i32 {
            let mut visited = vec![vec![false; n]; m];
            let mut components = 0;

            let mut dfs = |r: usize, c: usize, visited_ref: &mut Vec<Vec<bool>>, grid_ref: &Vec<Vec<i32>>| {
                let mut stack = vec![(r, c)];
                visited_ref[r][c] = true;

                let dr = [-1, 1, 0, 0];
                let dc = [0, 0, -1, 1];

                while let Some((curr_r, curr_c)) = stack.pop() {
                    for i in 0..4 {
                        let nr = curr_r as i32 + dr[i];
                        let nc = curr_c as i32 + dc[i];

                        if nr >= 0 && nr < m as i32 && nc >= 0 && nc < n as i32 {
                            let nr = nr as usize;
                            let nc = nc as usize;
                            if grid_ref[nr][nc] == 1 && !visited_ref[nr][nc] {
                                visited_ref[nr][nc] = true;
                                stack.push((nr, nc));
                            }
                        }
                    }
                }
            };

            for r_idx in 0..m {
                for c_idx in 0..n {
                    if current_grid[r_idx][c_idx] == 1 && !visited[r_idx][c_idx] {
                        components += 1;
                        dfs(r_idx, c_idx, &mut visited, current_grid);
                    }
                }
            }
            components
        };

        let initial_components = count_components(&grid);

        if initial_components != 1 {
            return 0;
        }

        for r in 0..m {
            for c in 0..n {
                if grid[r][c] == 1 {
                    grid[r][c] = 0;
                    let components_after_flip = count_components(&grid);
                    grid[r][c] = 1;

                    if components_after_flip != 1 {
                        return 1;
                    }
                }
            }
        }

        2
    }
}